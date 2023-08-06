import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';

import '../auth/auth_porvider.dart';
import '../ui/style/colors_app.dart';
import '../ui/style/text_style.dart';

class HomeDrawer extends StatelessWidget {
  Widget _createItem(String label, Function onTap) {
    return ListTile(
      title: Text(
        label,
        style: TextStyles.inst.textRegular.copyWith(fontSize: 24),
      ),
      onTap: () => onTap.call(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = context.read<AuthPorvider>().user;
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: ColorsApp.inst.primary),
            child: const Text(
              'Name',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
          _createItem(
            'XXXXXXXXXXXXXX',
            () {
              Navigator.pop(context);
            },
          ),
          _createItem(
            'SSSSSSSSSSSSSSSSSSSS',
            () {
              Navigator.pop(context);
            },
          ),
          TextButton(
              onPressed: () {
                context.read<AuthPorvider>().logout();
              },
              child: Text('Logout',
                  style: context.titleStyle
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}
/**TextButton(
            ), */