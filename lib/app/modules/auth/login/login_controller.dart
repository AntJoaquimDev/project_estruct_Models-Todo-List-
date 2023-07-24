import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;
  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> googleLogin() async {
    try {
      showLoadingAndRessetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.googleLogin();
      if (user != null) {
        success();
      } else {
        _userService.googleLogout();
        setError(' Erro ao realizar login com o Google');
      }
    } on AuthException catch (e) {
      _userService.googleLogout();
      setError(e.message);
    } finally {
      hideLoanding();
      notifyListeners();
    }
  }

  Future<void> googleLogout() async {}

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndRessetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.login(email, password);
      if (user != null) {
        success();
      } else {
        setError('Usuário inválido');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoanding();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndRessetState();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = 'Reset de Senha enviado para seu e-mail.';
    } on AuthException catch (e) {
      setError('e.message $e');
    } catch (e) {
      setError('Erro ao resetar a senha.');
    } finally {
      hideLoanding();
      notifyListeners();
    }
  }
}
