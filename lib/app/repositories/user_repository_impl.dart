import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';

import 'package:todo_list_provider/app/repositories/user_repository.dart';

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
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'wrong-password') {
        throw AuthException(message: 'Login ou senha inválidos');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    }
  }
}
