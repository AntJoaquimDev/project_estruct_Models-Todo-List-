import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/style/colors_app.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:todo_list_provider/app/core/widgets/home_drawer.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_task.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_week_filter.dart';
import 'package:todo_list_provider/app/modules/tasks/task_module.dart';
import 'package:todo_list_provider/app/utils/todo_routes.dart';

import 'home_filters.dart';
import 'home_header.dart';

class HomePage extends StatefulWidget {
  final HomeController _homeController;
  HomePage({required HomeController homeController, super.key})
      : _homeController = homeController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: widget._homeController).Listener(
      context: context,
      successVoidCalback: (notifier, listenerInstance) {
        listenerInstance.dispose();
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget._homeController.loadTotalTasks();
      widget._homeController.findTasks(filter: TaskFilterEnum.today);
    });
  }

  Future<void> _goToCreateTask(BuildContext context) async {
    await Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 450),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return TaskModule().getPage(TodoRoutes.TASK, context);
        }));
    widget._homeController.refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    // Widget showController = widget._homeController.showOrHIderFinishingTaskd();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorsApp.inst.primary),
          backgroundColor: ColorsApp.inst.Scaffold1,
          elevation: 0,
          title: const Text('Home-Page'),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                widget._homeController.showOrHIderFinishingTaskd();
              },
              icon: const Icon(TodoListIcons.filter),
              itemBuilder: (_) => [
                PopupMenuItem<bool>(
                  value: true,
                  child: Text(
                      '${widget._homeController.showFinishingTasks ? 'Esconder' : 'Mostrar'} Tarefas concluidas.'),
                ),
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _goToCreateTask(context),
          backgroundColor: context.primaryColor,
        ),
        backgroundColor: ColorsApp.inst.Scaffold1,
        drawer: HomeDrawer(),
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxWidth: constraints.maxWidth,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(),
                      HomeFilters(),
                      HomeWeekFilter(),
                      HomeTask(),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
/*Center(
        child: TextButton(
            onPressed: () {
              context.read<AuthPorvider>().logout();
            },
            child: const Text('Logout')),
      ), */