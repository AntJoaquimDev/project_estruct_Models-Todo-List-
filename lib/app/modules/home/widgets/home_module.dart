import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_page.dart';
import 'package:todo_list_provider/app/utils/todo_routes.dart';

class HomeModule extends TodoListModules {
  HomeModule()
      : super(
          // bindings: [],
          routers: {
            TodoRoutes.HOME: (context) => const HomePage(),
          },
        );
}
