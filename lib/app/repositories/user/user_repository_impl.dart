// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;
  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      if (e.code == 'email-already-in-use') {
        final loginType = await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginType.contains('password')) {
          throw AuthException(
              message: 'E-mail já utilizado, por favor escolha outro');
        } else {
          throw AuthException(
              message:
                  'Você se cadastrou no App Todo List com o Google. Utile para entrar. ');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      if (e.code == 'wrong-password') {
        throw AuthException(message: 'Login ou senha inválidos');
      }
      if (e.code == 'invalid-email') {
        throw AuthException(message: 'Loigin ou senha inválidos');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
            message: 'Cadastro com google. Não pode ser resetado a senha. ');
      } else {
        throw AuthException(message: 'Email nao cadastrado não encontrado. ');
      }
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: 'Erro ao resetar a senha .');
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);

        if (loginMethods.contains('password')) {
          throw AuthException(
              message:
                  'Você utilizou o e-mail para cadastro no TodoList, caso tenha esquecido sua senha por favor clique no link esqueci minha senha');
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredencial = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          var userCredencial =
              await _firebaseAuth.signInWithCredential(firebaseCredencial);
          return userCredencial.user;
        }
      }
    } on FirebaseException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(
            message:
                'Login inválido voce se registrou no TodoList com os seguintes provedores: ${loginMethods?.join(',')}');
      } else {
        throw AuthException(message: 'Erro ao realizar login');
      }
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }
}
