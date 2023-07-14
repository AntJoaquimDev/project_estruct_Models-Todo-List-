import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';

class BottunClipOval extends StatelessWidget {
  const BottunClipOval({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: context.primaryColor.withAlpha(20),
        padding: const EdgeInsets.all(8),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
      ),
    );
  }
}
