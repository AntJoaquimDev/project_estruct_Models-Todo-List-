import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 243, 212, 212),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Color.fromARGB(181, 158, 158, 158)),
          ]),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          leading: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
          title: const Text(
            'Descricao da Task',
            style: TextStyle(
                decoration: false ? TextDecoration.lineThrough : null),
          ),
          subtitle: const Text(
            '03/08/2023',
            style: TextStyle(
                decoration: false ? TextDecoration.lineThrough : null),
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
