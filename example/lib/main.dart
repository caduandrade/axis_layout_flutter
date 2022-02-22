import 'package:axis_layout/axis_layout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AxisLayoutDemoApp());
}

class AxisLayoutDemoApp extends StatelessWidget {
  const AxisLayoutDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Axis Layout Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Axis Layout Demo'),
        ),
        body: Center(child: _axisLayout()));
  }

  Widget _axisLayout() {
    return AxisLayout(axis: Axis.horizontal, children: const [
      AxisLayoutChild(child: Text('Axis Layout'), shrink: .5),
      Text('Axis Layout')
    ]);
  }
}
