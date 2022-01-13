import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isVisible = true;

  bool get isVisible => _isVisible;

  set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    if (email.isEmpty) return false;

    if (password.isEmpty) return false;

    debugPrint(' formulario valido : ${formKey.currentState?.validate()}');
    debugPrint(' datos :  $email - $password');

    return formKey.currentState?.validate() ?? false;
  }
}
