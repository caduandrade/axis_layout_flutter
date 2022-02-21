import 'package:demo/catalog_widget.dart';
import 'package:demo/layout_widget.dart';
import 'package:demo/settings.dart';
import 'package:demo/settings_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> _types = [];
  Settings _settings = Settings(axis: Axis.horizontal, scrollable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Axis Layout Demo'),
        ),
        body: _body(context));
  }

  Widget _body(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      const double settingsFinalX = 300;
      const double catalogFinalY = 200;

      return Stack(children: [
        Positioned(
            top: catalogFinalY,
            left: settingsFinalX,
            right: 0,
            bottom: 0,
            child: LayoutWidget(types: _types, settings: _settings)),
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: SizedBox(child: SettingsWidget(), width: settingsFinalX)),
        Positioned(
            top: 0,
            left: settingsFinalX,
            right: 0,
            child: SizedBox(
                child: CatalogWidget(onChildTypeClick: _onChildTypeClick),
                height: catalogFinalY))
      ]);
    });
  }

  void _onChildTypeClick(int type) {
    setState(() {
      _types.add(type);
    });
  }
}
