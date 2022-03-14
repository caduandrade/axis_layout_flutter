import 'package:axis_layout/axis_layout.dart';
import 'package:flutter/material.dart';

class ChildType {
  ChildType(
      {required this.type, required this.constraints, required this.color});

  final int type;
  final BoxConstraints constraints;
  final Color color;

  Widget _build(bool limited) {
    Widget? text;
    if (type == 1) {
      text = const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
    }

    return ConstrainedBox(
        constraints:
            limited ? constraints.copyWith(maxWidth: 100) : constraints,
        child: Container(color: color, child: text));
  }

  Widget buildForCatalog() {
    return _build(true);
  }

  Widget buildForLayout(
      {required double shrink,
      required int shrinkOrder,
      required double expand}) {
    return AxisLayoutChild(
        child: _build(false),
        shrink: shrink,
        shrinkOrder: shrinkOrder,
        expand: expand);
  }

  static List<ChildType> types = [
    ChildType(
        type: 1,
        constraints: const BoxConstraints(),
        color: Colors.yellow[200]!),
    ChildType(
        type: 2,
        constraints: BoxConstraints.tight(const Size(100, 50)),
        color: Colors.blue),
    ChildType(
        type: 3,
        constraints: const BoxConstraints(
            minWidth: 0, maxWidth: 100, minHeight: 100, maxHeight: 100),
        color: Colors.blue[300]!),
    ChildType(
        type: 4,
        constraints: BoxConstraints.tight(const Size(50, 100)),
        color: Colors.green),
    ChildType(
        type: 5,
        constraints: const BoxConstraints(
            minWidth: 0, maxWidth: 100, minHeight: 100, maxHeight: 100),
        color: Colors.green[300]!)
  ];
}
