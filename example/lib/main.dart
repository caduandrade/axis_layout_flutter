import 'package:axis_layout/axis_layout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AxisLayoutExampleApp());
}

class AxisLayoutExampleApp extends StatelessWidget {
  const AxisLayoutExampleApp({Key? key}) : super(key: key);

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
  double _width = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Axis Layout Demo'),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Center(child: SizedBox(width: 400, child: _slider())),
          Center(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 4)),
                  child: SizedBox(width: _width, child: _axisLayout())))
        ]));
  }

  Widget _slider() {
    return Slider(
        min: 0,
        max: 400,
        value: _width,
        onChanged: (value) {
          setState(() {
            _width = value;
          });
        });
  }

  Widget _axisLayout() {
    return AxisLayout(axis: Axis.horizontal, children: [
      AxisLayoutChild(
          child: Container(width: 100, height: 50, color: Colors.blue),
          shrink: 1),
      Container(width: 100, height: 50, color: Colors.orange),
      AxisLayoutChild(
          child: Container(height: 50, color: Colors.green), expand: 1)
    ]);
  }
}
