// ignore_for_file: use_key_in_widget_constructors

import 'package:auth_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import 'package:auth_app/provider/auth_provider.dart';
import 'package:auth_app/services/auth_fire_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthFirebaseService>(context);
    final usuario = ModalRoute.of(context)!.settings.arguments as AuthProvider;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: const Text('Bienvenido'),
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            authService.logout();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoginScreen(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(usuario.nombre ?? 'no-name'),
            Text(usuario.email),
            Text(usuario.password),
          ],
        ),
      ),
    );
  }
}
