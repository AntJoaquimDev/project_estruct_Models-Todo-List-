import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_list_provider/app/core/navigator/todo_list_navigator.dart';

import 'package:todo_list_provider/app/services/user/user_service.dart';

import '../../utils/todo_routes.dart';

class AuthPorvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;
  AuthPorvider({
    required FirebaseAuth firebaseAuth,
    required UserService userService,
  })  : _firebaseAuth = firebaseAuth,
        _userService = userService;

  Future<void> logout() => _userService.logout();
  User? get user => _firebaseAuth.currentUser;

  void loadListener() {
    _firebaseAuth.userChanges().listen((_) => notifyListeners());
    //_firebaseAuth.idTokenChanges().listen((user) {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        TodoListNavigator.to
            .pushNamedAndRemoveUntil(TodoRoutes.HOME, (route) => false);
      } else {
        TodoListNavigator.to
            .pushNamedAndRemoveUntil(TodoRoutes.LOGIN, (route) => false);
      }
    });
  }
}
