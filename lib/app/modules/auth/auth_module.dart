import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_page.dart';
import 'package:todo_list_provider/app/modules/auth/registers/register_controller.dart';
import 'package:todo_list_provider/app/modules/auth/registers/register_page.dart';
import 'package:todo_list_provider/app/utils/todo_routes.dart';

class AuthModule extends TodoListModules {
  AuthModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (context) => LoginController(userService: context.read()),
              //lazy: false,
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  RegisterController(userService: context.read()),
              //lazy: false,
            )
          ],
          routers: {
            // TodoRoutes.SPLASH: (context) => const SplashPage(),
            // TodoRoutes.HOME: (context) => const HomePage(),
            TodoRoutes.LOGIN: (context) => const LoginPage(),
            TodoRoutes.REGISTER: (context) => RegisterPage(),
          },
        );
}
