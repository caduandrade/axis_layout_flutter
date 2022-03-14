import 'package:axis_layout/axis_layout.dart';
import 'package:demo/catalog_widget.dart';
import 'package:demo/layout_widget.dart';
import 'package:demo/layout_settings.dart';
import 'package:demo/layout_settings_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _children = [];
  LayoutSettings _settings = LayoutSettings(
      axis: Axis.horizontal,
      mainAlignment: MainAlignment.start,
      crossAlignment: CrossAlignment.center,
      antiAliasingBugWorkaround: false,
      clip: Clip.none);

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
      return Row(children: [
        LayoutSettingsWidget(
            settings: _settings, onSettingsChange: _onSettingsChange),
        Expanded(
            child: LayoutWidget(
                children: _children, settings: _settings, onClear: _onClear)),
        CatalogWidget(onChildTypeClick: _onChildTypeClick)
      ], crossAxisAlignment: CrossAxisAlignment.stretch);
    });
  }

  void _onClear() {
    setState(() {
      _children.clear();
    });
  }

  void _onSettingsChange(LayoutSettings settings) {
    setState(() {
      _settings = settings;
    });
  }

  void _onChildTypeClick(Widget child) {
    setState(() {
      _children.add(child);
    });
  }
}
