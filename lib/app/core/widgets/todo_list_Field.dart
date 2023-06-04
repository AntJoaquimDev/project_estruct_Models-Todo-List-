import 'package:flutter/material.dart';

import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final IconButton? suffixoIconButton;
  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  TodoListField({
    Key? key,
    required this.label,
    this.suffixoIconButton,
    this.obscureText = false,
    this.controller,
    this.validator,
  })  : assert(obscureText == true ? suffixoIconButton == null : true,
            'obscuretext não pode ser usado com sufixxIconButtom'),
        obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red),
            ),
            isDense: true,
            suffixIcon: suffixoIconButton ??
                (obscureText == true
                    ? IconButton(
                        onPressed: () {
                          obscureTextVN.value = !obscureTextValue;
                        },
                        icon: !obscureTextValue
                            ? const Icon(TodoListIcons.eye)
                            : const Icon(TodoListIcons.eye_slash),
                        iconSize: 15,
                      )
                    : null),
          ),
        );
      },
    );
  }
}
