import 'package:axis_layout/axis_layout.dart';
import 'package:demo/child_builder.dart';
import 'package:demo/settings.dart';
import 'package:flutter/material.dart';

class LayoutWidget extends StatefulWidget {
  const LayoutWidget({Key? key, required this.types, required this.settings})
      : super(key: key);

  final List<int> types;
  final Settings settings;

  @override
  State<StatefulWidget> createState() => LayoutWidgetState();
}

class LayoutWidgetState extends State<LayoutWidget> {
  static const double _maxMainSize = 400;

  double _mainSize = _maxMainSize;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [Expanded(child: _axisLayoutContainer())];
    if (!widget.settings.scrollable) {
      children.insert(
          0,
          Center(
              child: SizedBox(width: _maxMainSize, child: _mainSizeSlider())));
    }
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
        color: Colors.white);
  }

  Widget _axisLayoutContainer() {
    Widget axisLayout = _axisLayout();
    if (widget.settings.scrollable) {
      axisLayout = SingleChildScrollView(
          child: axisLayout, scrollDirection: widget.settings.axis);
    }
    return Center(
        child: Container(
            child: axisLayout,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 8))));
  }

  Widget _axisLayout() {
    List<Widget> children = [];
    for (int type in widget.types) {
      children.add(ChildBuilder.build(type: type));
    }
    AxisLayout axisLayout =
        AxisLayout(axis: Axis.horizontal, children: children);
    if (widget.settings.scrollable == false) {
      if (widget.settings.axis == Axis.horizontal) {
        return SizedBox(width: _mainSize, child: axisLayout);
      }
      return SizedBox(height: _mainSize, child: axisLayout);
    }
    return axisLayout;
  }

  Widget _mainSizeSlider() {
    return Slider(
        value: _mainSize,
        min: 0,
        max: _maxMainSize,
        onChanged: (value) {
          setState(() {
            _mainSize = value;
          });
        });
  }
}
