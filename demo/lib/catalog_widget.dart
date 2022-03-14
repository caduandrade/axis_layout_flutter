import 'package:demo/child_types.dart';
import 'package:flutter/material.dart';

typedef OnChildTypeClick = void Function(Widget child);

class CatalogWidget extends StatefulWidget {
  const CatalogWidget({Key? key, required this.onChildTypeClick})
      : super(key: key);

  final OnChildTypeClick onChildTypeClick;

  @override
  State<StatefulWidget> createState() => CatalogWidgetState();
}

class CatalogWidgetState extends State<CatalogWidget> {
  double _shrink = 0;
  double _expand = 0;
  double _shrinkOrder = 0;
  final ScrollController _childrenScrollController = ScrollController();
  final ScrollController _settingsScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [_childrenList(context), _settings(context)],
        crossAxisAlignment: CrossAxisAlignment.stretch);
  }

  Widget _settings(BuildContext context) {
    List<Widget> children = [
      const ListTile(title: Text('Child settings')),
      ListTile(
          title: Text('Shrink: ${_shrink.toStringAsFixed(2)}'), dense: true),
      _shrinkSlider(),
      ListTile(
          title: Text('Shrink order: ${_shrinkOrder.toInt()}'), dense: true),
      _shrinkOrderSlider(),
      ListTile(title: Text('Expand: ${_expand.toInt()}'), dense: true),
      _expandSlider()
    ];

    return Container(
        width: 200,
        child: SingleChildScrollView(
            controller: _settingsScrollController,
            child: Column(
                children: children,
                crossAxisAlignment: CrossAxisAlignment.stretch)),
        decoration: _decoration());
  }

  Widget _childrenList(BuildContext context) {
    List<Widget> children = [];
    for (ChildType childType in ChildType.types) {
      children.add(_childItem(childType));
    }
    return Container(
        width: 250,
        child: SingleChildScrollView(
          controller: _childrenScrollController,
          child: Column(children: children),
        ),
        decoration: _decoration());
  }

  Widget _childItem(ChildType childType) {
    BoxConstraints constraints = childType.constraints;
    return Material(
        child: InkWell(
            child: Padding(
                child: Row(children: [
                  childType.buildForCatalog(),
                  const SizedBox(width: 16),
                  Text(
                      'minW: ${constraints.minWidth}\nmaxW: ${constraints.maxWidth}\nminH: ${constraints.minHeight}\nmaxH: ${constraints.maxHeight}')
                ], crossAxisAlignment: CrossAxisAlignment.center),
                padding: const EdgeInsets.all(8)),
            onTap: () => _onChildTypeClick(childType)));
  }

  void _onChildTypeClick(ChildType childType) {
    Widget item = childType.buildForLayout(
        shrink: _shrink, shrinkOrder: _shrinkOrder.toInt(), expand: _expand);
    widget.onChildTypeClick(item);
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: Colors.grey[700]!, width: 2)));
  }

  Widget _expandSlider() {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(children: [
          const Text('0'),
          Expanded(
              child: Slider(
                  value: _expand,
                  min: 0,
                  max: 100,
                  divisions: 20,
                  onChanged: (value) {
                    setState(() {
                      _expand = value;
                    });
                  })),
          const Text('100')
        ]));
  }

  Widget _shrinkSlider() {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(children: [
          const Text('0'),
          Expanded(
              child: Slider(
                  value: _shrink,
                  min: 0,
                  max: 1,
                  divisions: 20,
                  onChanged: (value) {
                    setState(() {
                      _shrink = value;
                    });
                  })),
          const Text('1')
        ]));
  }

  Widget _shrinkOrderSlider() {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(children: [
          const Text('0'),
          Expanded(
              child: Slider(
                  value: _shrinkOrder,
                  min: 0,
                  max: 5,
                  divisions: 5,
                  onChanged: (value) {
                    setState(() {
                      _shrinkOrder = value;
                    });
                  })),
          const Text('5')
        ]));
  }
}
