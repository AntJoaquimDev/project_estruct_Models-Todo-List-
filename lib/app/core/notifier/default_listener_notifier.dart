import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';

class DefaultListenerNotifier {
  DefaultChangeNotifier changeNotifier;

  DefaultListenerNotifier({
    required this.changeNotifier,
  });

  void Listener(
      {required BuildContext context,
      required SuccessVoidCalback successVoidCalback,
      ErroVoidCalback? erroVoidCalback}) {
    changeNotifier.addListener(() {
      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if (changeNotifier.hasError) {
          if (erroVoidCalback != null) {
            erroVoidCalback(changeNotifier, this);
          }
        }
        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      } else if (changeNotifier.isSuccess) {
        if (successVoidCalback != null) {
          successVoidCalback(changeNotifier, this);
        }
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCalback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstace);
typedef ErroVoidCalback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstace);
