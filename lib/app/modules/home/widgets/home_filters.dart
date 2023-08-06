import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/modules/home/widgets/todo_card_filters.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: context.titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(label: 'Hoje'),
              TodoCardFilter(
                label: 'Amanhã',
              ),
              TodoCardFilter(
                label: 'Semana',
              ),
            ],
          ),
        )
      ],
    );
  }
}
