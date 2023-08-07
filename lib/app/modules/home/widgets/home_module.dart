import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_page.dart';
import 'package:todo_list_provider/app/utils/todo_routes.dart';

class HomeModule extends TodoListModules {
  HomeModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (contex) => HomeController(),
            ),
          ],
          routers: {
            TodoRoutes.HOME: (context) => const HomePage(),
          },
        );
}
