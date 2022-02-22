import 'package:axis_layout/axis_layout.dart';
import 'package:flutter/material.dart';

class ChildType {
  ChildType(
      {required this.type, required this.constraints, required this.color});

  final int type;
  final BoxConstraints constraints;
  final Color color;

  Widget buildForCatalog() {
    return ConstrainedBox(
        constraints: constraints, child: Container(color: color));
  }

  Widget buildForLayout({required double shrink, required int shrinkOrder}) {
    return AxisLayoutChild(
      child: buildForCatalog(),
      shrink: shrink,
      shrinkOrder: shrinkOrder,
    );
  }

  static List<ChildType> types = [
    ChildType(
        type: 1,
        constraints: BoxConstraints.tight(const Size(100, 50)),
        color: Colors.blue),
    ChildType(
        type: 2,
        constraints: const BoxConstraints(
            minWidth: 0, maxWidth: 100, minHeight: 100, maxHeight: 100),
        color: Colors.blue[300]!),
    ChildType(
        type: 3,
        constraints: BoxConstraints.tight(const Size(50, 100)),
        color: Colors.green),
    ChildType(
        type: 4,
        constraints: const BoxConstraints(
            minWidth: 0, maxWidth: 100, minHeight: 100, maxHeight: 100),
        color: Colors.green[300]!)
  ];
}
