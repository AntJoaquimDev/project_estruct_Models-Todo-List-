import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_page.dart';
import 'package:todo_list_provider/app/modules/auth/registers/register_controller.dart';
import 'package:todo_list_provider/app/modules/auth/registers/register_page.dart';
import 'package:todo_list_provider/app/modules/splash/splash_page.dart';
import 'package:todo_list_provider/app/utils/todo_routes.dart';

class AuthModule extends TodoListModules {
  AuthModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (_) => LoginController(),
              lazy: false,
            ),
            ChangeNotifierProvider(
              create: (_) => RegisterController(),
              lazy: false,
            )
          ],
          routers: {
            //'/': (context) => const SplashPage(),
            TodoRoutes.LOGIN: (context) => const LoginPage(),
            TodoRoutes.REGISTER: (context) => const RegisterPage(),
          },
        );
}
