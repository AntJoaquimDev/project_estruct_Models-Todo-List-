import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_page.dart';
import 'package:todo_list_provider/app/repositories/task/task_repository.dart';
import 'package:todo_list_provider/app/repositories/task/task_repository_impl.dart';
import 'package:todo_list_provider/app/services/task/task_service.dart';
import 'package:todo_list_provider/app/services/task/task_service_impl.dart';
import 'package:todo_list_provider/app/utils/todo_routes.dart';

class HomeModule extends TodoListModules {
  HomeModule()
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
              create: (contex) => HomeController(TaskService: contex.read()),
            ),
          ],
          routers: {
            TodoRoutes.HOME: (context) =>
                HomePage(homeController: context.read()),
          },
        );
}
