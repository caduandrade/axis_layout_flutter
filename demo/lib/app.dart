import 'package:demo/home_page.dart';
import 'package:flutter/material.dart';

class AxisLayoutDemoApp extends StatelessWidget {
  const AxisLayoutDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Axis Layout Demo',
      theme: ThemeData(
        radioTheme: const RadioThemeData( materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
