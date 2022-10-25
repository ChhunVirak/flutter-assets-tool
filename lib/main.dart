import 'package:flutter/material.dart';
import 'package:flutter_project_tools/core/color_constant.dart';
import 'package:flutter_project_tools/module/home/page/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project',
      theme: ThemeData(primarySwatch: MaterialColors().materialtheme),
      home: const SplashScreen(),
    );
  }
}
