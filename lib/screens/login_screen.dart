// ignore_for_file: use_key_in_widget_constructors

import 'package:auth_app/screens/register_screen.dart';
import 'package:auth_app/widgets/auth_background.dart';
import 'package:auth_app/widgets/custom_buttom_sign.dart';
import 'package:auth_app/widgets/custom_field.dart';
import 'package:flutter/material.dart';

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
                _LoginForm(),
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
    return Form(
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
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 30),
          // Password
          CustomTextField(
            child: TextFormField(
              obscureText: true, // condicion aca
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
                  icon: Icon(
                    Icons.visibility_off, //visibility_rounded
                    size: 24,
                    color: primary,
                  ),
                  onPressed: () {},
                ),
              ),
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 80),
          // Sign in
          CustomButtomSign(
            text: 'Sign In',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
