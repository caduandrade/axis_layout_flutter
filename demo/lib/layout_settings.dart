import 'package:axis_layout/axis_layout.dart';
import 'package:flutter/widgets.dart';

class LayoutSettings {
  LayoutSettings(
      {required this.axis,
      required this.mainAlignment,
      required this.crossAlignment});

  final Axis axis;
  final MainAlignment mainAlignment;
  final CrossAlignment crossAlignment;

  /// Creates a copy of this settings but with the given fields replaced with the new values.
  LayoutSettings copyWith(
      {Axis? axis,
      bool? scrollable,
      MainAlignment? mainAlignment,
      CrossAlignment? crossAlignment}) {
    return LayoutSettings(
        axis: axis ?? this.axis,
        mainAlignment: mainAlignment ?? this.mainAlignment,
        crossAlignment: crossAlignment ?? this.crossAlignment);
  }
}