import 'package:flutter/material.dart';
import 'package:onlineinspection/core/hook/hook.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text('login page'),
      )
    );
  }
}