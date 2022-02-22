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

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Center(child: SizedBox(width: _maxMainSize, child: _mainSizeSlider())),
      Expanded(child: _axisLayoutContainer())
    ];

    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
        color: Colors.white);
  }

  Widget _axisLayoutContainer() {
    Widget axisLayout = _axisLayout();
    if (widget.settings.scrollable) {
      axisLayout = Scrollbar(
          child: SingleChildScrollView(
              child: axisLayout,
              scrollDirection: widget.settings.axis,
              controller: _scrollController),
          controller: _scrollController,
          isAlwaysShown: true);
    }

    if (widget.settings.axis == Axis.horizontal) {
      axisLayout = SizedBox(width: _mainSize, child: axisLayout);
    } else {
      axisLayout = SizedBox(height: _mainSize, child: axisLayout);
    }

    return Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400),
            child: Container(
                child: Center(
                    child: Container(
                        child: axisLayout,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 8)))),
                color: Colors.grey[300])));
  }

  Widget _axisLayout() {
    List<Widget> children = [];
    for (int type in widget.types) {
      children.add(ChildBuilder.build(type: type));
    }
    return AxisLayout(
      axis: widget.settings.axis,
      children: children,
      mainAlignment: widget.settings.mainAlignment,
      crossAlignment: widget.settings.crossAlignment,
    );
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
