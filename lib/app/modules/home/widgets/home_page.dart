import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/style/colors_app.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:todo_list_provider/app/core/widgets/home_drawer.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_task.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_week_filter.dart';
import 'package:todo_list_provider/app/modules/tasks/task_module.dart';
import 'package:todo_list_provider/app/utils/todo_routes.dart';

import 'home_filters.dart';
import 'home_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goToCreateTask(BuildContext context) {
    //Navigator.of(context).pushNamed(TodoRoutes.TASK);
    // Navigator.of(context).push(MaterialPageRoute(
    //  builder: (_) => TaskModule().getPage(TodoRoutes.TASK, context)));
    Navigator.of(context).push(PageRouteBuilder(
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorsApp.inst.primary),
          backgroundColor: ColorsApp.inst.Scaffold1,
          elevation: 0,
          title: const Text('Home-Page'),
          actions: [
            PopupMenuButton(
              icon: const Icon(TodoListIcons.filter),
              itemBuilder: (_) => [
                const PopupMenuItem<bool>(child: Text('Mostrar Tarefas')),
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
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