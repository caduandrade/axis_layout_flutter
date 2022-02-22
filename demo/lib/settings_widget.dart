import 'package:axis_layout/axis_layout.dart';
import 'package:demo/settings.dart';
import 'package:flutter/material.dart';

typedef OnSettingsChange = void Function(Settings settings);

class SettingsWidget extends StatefulWidget {
  const SettingsWidget(
      {Key? key, required this.settings, required this.onSettingsChange})
      : super(key: key);

  final OnSettingsChange onSettingsChange;
  final Settings settings;

  @override
  State<StatefulWidget> createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(child: _menu()),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(right: BorderSide(color: Colors.grey[700]!, width: 2))));
  }

  Widget _menu() {

    List<Widget> children = [
      const ListTile(title: Text('Axis')),
      _horizontalRadio(),
      _verticalRadio(),
      const ListTile(title: Text('MainAlignment')),
    ];

    for(MainAlignment mainAlignment in MainAlignment.values) {
      children.add(_mainAlignmentRadio(mainAlignment));
    }

    children.add(const ListTile(title: Text('CrossAlignment')));
    for(CrossAlignment crossAlignment in CrossAlignment.values) {
      children.add(_crossAlignmentRadio(crossAlignment));
    }

    return Column(
      children: children
    );
  }

  Widget _horizontalRadio() {
    return _axisRadio(Axis.horizontal);
  }

  Widget _verticalRadio() {
    return _axisRadio(Axis.vertical);
  }

  Widget _axisRadio(Axis axis) {
    return RadioListTile<Axis>(
        title: Text(axis.name),
        value: axis,
        groupValue: widget.settings.axis,
        onChanged: _onAxisChange,
        dense: true
    );
  }

  Widget _mainAlignmentRadio(MainAlignment value) {
    return RadioListTile<MainAlignment>(
        title: Text(value.name),
        value: value,
        groupValue: widget.settings.mainAlignment,
        onChanged: _onMainAlignmentChange,
        dense: true
    );
  }

  Widget _crossAlignmentRadio(CrossAlignment value) {
    return RadioListTile<CrossAlignment>(
        title: Text(value.name),
        value: value,
        groupValue: widget.settings.crossAlignment,
        onChanged: _onCrossAlignmentChange,
        dense: true
    );
  }

  void _onAxisChange(Axis? value) {
    _notifySettingChange(widget.settings.copyWith(axis: value));
  }

  void _onMainAlignmentChange(MainAlignment? value){
    _notifySettingChange(widget.settings.copyWith(mainAlignment: value));
  }

  void _onCrossAlignmentChange(CrossAlignment? value){
    _notifySettingChange(widget.settings.copyWith(crossAlignment: value));
  }
  
  void _notifySettingChange(Settings settings) {
    widget.onSettingsChange(settings);
  }
}
