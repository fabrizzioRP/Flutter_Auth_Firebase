// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  final String image;

  const AuthBackground({
    required this.image,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
              width: double.infinity,
              height: 300,
              child: SvgPicture.asset(image),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
