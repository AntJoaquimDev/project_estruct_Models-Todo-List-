import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_page.dart';
import 'package:todo_list_provider/app/repositories/task/task_repository.dart';
import 'package:todo_list_provider/app/repositories/task/task_repository_impl.dart';
import 'package:todo_list_provider/app/services/task/task_service.dart';
import 'package:todo_list_provider/app/services/task/task_service_impl.dart';
import 'package:todo_list_provider/app/utils/todo_routes.dart';

class TaskModule extends TodoListModules {
  TaskModule()
      : super(
          bindings: [
            Provider<TaskRepository>(
              create: (context) =>
                  TaskRepositoryImpl(sqliteConectorFactory: context.read()),
            ),
            Provider<TaskService>(
              create: (contex) =>
                  TaskServiceImpl(taskRepository: contex.read()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  TaskCreateController(taskService: context.read()),
            )
          ],
          routers: {
            TodoRoutes.TASK: (context) => TaskCreatePage(
                  controller: context.read(),
                ),
          },
        );
}
