import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_porvider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Selector<AuthPorvider, String>(
        selector: (context, authPorvider) =>
            authPorvider.user?.displayName ?? 'User infomrado',
        builder: (_, value, __) {
          return Text('$value !',
              style: context.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold));
        },
      ),
    );
  }
}
