import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? nombre = 'no-name';
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

  bool validEmail(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email) ? true : false;
  }

  isValidForm() {
    try {
      if (email.isEmpty) return false;

      if (password.isEmpty) return false;

      if (!validEmail(email)) return false;

      // debugPrint(' formulario valido : ${formKey.currentState?.validate()}');
      // debugPrint(' datos :  $email - $password');

      return formKey.currentState?.validate() ?? false;
    } catch (error) {
      throw ' Error en la validacion :  $error';
    }
  }
}
