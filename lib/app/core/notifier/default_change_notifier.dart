import 'package:flutter/cupertino.dart';

class DefaultChangeNotifier extends ChangeNotifier {
  bool _loading = false;
  bool _success = false;
  String? _error;

  bool get loading => _loading;

  String? get error => _error;

  bool get hasError => _error != error;

  bool get isSuccess => _success;

  void showLoanding() => _loading = true;
  void hideLoanding() => _loading = false;

  void success() => _success = true;

  void setError(String? error) => _error = error;

  void showLoadingAndRessetState() {
    showLoanding();
    resetState();
  }

  void resetState() {
    setError(null);
    _success = false;
  }
}
