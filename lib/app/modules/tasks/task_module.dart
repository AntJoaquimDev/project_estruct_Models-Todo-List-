import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_page.dart';
import 'package:todo_list_provider/app/utils/todo_routes.dart';

class TaskModule extends TodoListModules {
  TaskModule()
      : super(bindings: [
          ChangeNotifierProvider(
            create: (context) => TaskCreateController(),
          )
        ], routers: {
          TodoRoutes.TASK: (context) => TaskCreatePage(
                controller: context.read(),
              ),
        });
}
