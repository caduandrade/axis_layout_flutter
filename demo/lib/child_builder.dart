import 'package:axis_layout/axis_layout.dart';
import 'package:flutter/material.dart';

typedef OnChildTypeClick = void Function(int type);

class ChildBuilder {
  static const int types = 2;

  static Widget build({required int type, OnChildTypeClick? onChildTypeClick}) {
    switch (type) {
      case 1:
        return _build(
            type: type,
            constraints: BoxConstraints.tight(const Size(100, 50)),
            color: Colors.blue,
            onChildTypeClick: onChildTypeClick);
      case 2:
        return _build(
            type: type,
            constraints: const BoxConstraints(
                minWidth: 0, maxWidth: 100, minHeight: 100, maxHeight: 100),
            color: Colors.blue[300]!,
            onChildTypeClick: onChildTypeClick);
    }
    return const Text('?');
  }

  static Widget _build(
      {required int type,
      required BoxConstraints constraints,
      required Color color,
      OnChildTypeClick? onChildTypeClick}) {
    Widget w = ConstrainedBox(
        constraints: constraints, child: Container(color: color));
    if (onChildTypeClick != null) {
      w = Material(
          child: InkWell(
              child: Padding(
                  child: Column(children: [
                    w,
                    const SizedBox(height: 8),
                    Text(_constraintsToString(constraints))
                  ], crossAxisAlignment: CrossAxisAlignment.center),
                  padding: const EdgeInsets.all(8)),
              onTap: () => onChildTypeClick(type)));
    } else {
      w = AxisLayoutChild(
        child: w,
        shrink: .5,
        shrinkOrder: type,
      );
    }
    return w;
  }

  static String _constraintsToString(BoxConstraints constraints) {
    return 'w: ${constraints.minWidth}/${constraints.maxWidth}\nh: ${constraints.minHeight}/${constraints.maxHeight}';
  }
}
