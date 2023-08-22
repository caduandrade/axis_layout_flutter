import 'package:axis_layout/axis_layout.dart';
import 'package:demo/layout_settings.dart';
import 'package:flutter/material.dart';

class LayoutWidget extends StatefulWidget {
  const LayoutWidget(
      {Key? key,
      required this.children,
      required this.settings,
      required VoidCallback onClear})
      : _onClear = onClear,
        super(key: key);

  final List<Widget> children;
  final LayoutSettings settings;
  final VoidCallback _onClear;

  @override
  State<StatefulWidget> createState() => LayoutWidgetState();
}

class LayoutWidgetState extends State<LayoutWidget> {
  static const double _maxMainSize = 400;

  double _mainSize = _maxMainSize;

  bool _scrollable = false;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Center(
          child: Container(
              padding: const EdgeInsets.only(top: 16),
              child: Row(children: [
                const SizedBox(width: 16),
                _clearButton(),
                const SizedBox(width: 32),
                const Text('Scrollable'),
                _scrollCheck()
              ]))),
      Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: SizedBox(width: _maxMainSize, child: _mainSizeSlider()))),
      Expanded(child: _axisLayoutContainer())
    ];

    return Container(
        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children));
  }

  Widget _axisLayoutContainer() {
    Widget axisLayout = _axisLayout();
    if (_scrollable) {
      axisLayout = Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
              scrollDirection: widget.settings.axis,
              controller: _scrollController,
              child: axisLayout));
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
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 8)),
                child: axisLayout)));
  }

  Widget _axisLayout() {
    return AxisLayout(
      axis: widget.settings.axis,
      mainAlignment: widget.settings.mainAlignment,
      crossAlignment: widget.settings.crossAlignment,
      antiAliasingBugWorkaround: widget.settings.antiAliasingBugWorkaround,
      clipBehavior: widget.settings.clip,
      children: widget.children,
    );
  }

  Widget _clearButton() {
    return ElevatedButton(
        onPressed: widget._onClear, child: const Text('Clear'));
  }

  Widget _scrollCheck() {
    return Checkbox(value: _scrollable, onChanged: _onScrollableValueChange);
  }

  void _onScrollableValueChange(bool? value) {
    setState(() {
      _scrollable = value!;
    });
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
