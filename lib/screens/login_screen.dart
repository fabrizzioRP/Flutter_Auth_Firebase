// ignore_for_file: use_key_in_widget_constructors

import 'package:auth_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import 'package:auth_app/widgets/custom_field.dart';
import 'package:auth_app/provider/auth_provider.dart';
import 'package:auth_app/widgets/auth_background.dart';
import 'package:auth_app/screens/register_screen.dart';
import 'package:auth_app/widgets/custom_buttom_sign.dart';
import 'package:auth_app/services/auth_fire_service.dart';

const imageSvg = 'assets/login.svg';
Color primary = Colors.white.withOpacity(0.6);

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AuthBackground(
        image: imageSvg,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.5),
                ChangeNotifierProvider(
                  create: (_) => AuthProvider(),
                  child: _LoginForm(),
                ),
                const SizedBox(height: 70),
                Text(
                  '¿No tienes Cuenta?',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    'Regístrate',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (_, value, ___) {
                          return FadeTransition(
                            opacity: value,
                            child: RegisterScreen(),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Form(
      key: authProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          // Email
          CustomTextField(
            child: TextFormField(
              cursorColor: Colors.tealAccent,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Email',
                hintStyle: TextStyle(color: primary),
                prefixIcon: Icon(
                  Icons.alternate_email_sharp,
                  size: 24,
                  color: primary,
                ),
              ),
              onChanged: (value) => authProvider.email = value,
            ),
          ),
          const SizedBox(height: 30),
          // Password
          CustomTextField(
            child: TextFormField(
              obscureText: authProvider.isVisible ? true : false,
              cursorColor: Colors.tealAccent,
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Password',
                hintStyle: TextStyle(color: primary),
                prefixIcon: Icon(
                  Icons.vpn_key_rounded,
                  size: 24,
                  color: primary,
                ),
                suffixIcon: IconButton(
                  icon: authProvider.isVisible
                      ? Icon(
                          Icons.visibility_off,
                          size: 24,
                          color: primary,
                        )
                      : Icon(
                          Icons.visibility_rounded,
                          size: 24,
                          color: primary,
                        ),
                  onPressed: () =>
                      authProvider.isVisible = !authProvider.isVisible,
                ),
              ),
              onChanged: (value) => authProvider.password = value,
            ),
          ),
          const SizedBox(height: 80),
          // Sign in
          CustomButtomSign(
            text: authProvider.isLoading ? 'Waiting...' : 'Sign In',
            onPressed: authProvider.isLoading
                ? () {}
                : () async {
                    FocusScope.of(context).unfocus();

                    final authService = Provider.of<AuthFirebaseService>(
                        context,
                        listen: false);

                    if (!authProvider.isValidForm()) {
                      return debugPrint('Formulario No valido');
                    }

                    authProvider.isLoading = true;

                    final String? messageError = await authService.loginUser(
                        authProvider.email, authProvider.password);

                    if (messageError == null) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          settings: RouteSettings(arguments: authProvider),
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder: (_, value, ___) => FadeTransition(
                            opacity: value,
                            child: HomeScreen(),
                          ),
                        ),
                      );
                      // authProvider.isLoading = false;
                    } else {
                      debugPrint(messageError);
                      authProvider.isLoading = false;
                    }
                  },
          ),
        ],
      ),
    );
  }
}
