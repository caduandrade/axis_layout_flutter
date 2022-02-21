import 'package:demo/child_builder.dart';
import 'package:flutter/material.dart';

class CatalogWidget extends StatelessWidget {
  const CatalogWidget({Key? key, required this.onChildTypeClick})
      : super(key: key);

  final OnChildTypeClick onChildTypeClick;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 1; i <= ChildBuilder.types; i++) {
      children
          .add(ChildBuilder.build(type: i, onChildTypeClick: onChildTypeClick));
    }
    return Container(
        child: Wrap(children: children, runSpacing: 8, spacing: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Colors.grey[700]!, width: 2))));
  }
}
