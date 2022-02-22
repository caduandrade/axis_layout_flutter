import 'package:axis_layout/axis_layout.dart';
import 'package:flutter/widgets.dart';

class Settings {
  Settings(
      {required this.axis,
      required this.scrollable,
      required this.mainAlignment,
      required this.crossAlignment});

  final Axis axis;
  final bool scrollable;
  final MainAlignment mainAlignment;
  final CrossAlignment crossAlignment;

  /// Creates a copy of this settings but with the given fields replaced with the new values.
  Settings copyWith(
      {Axis? axis,
      bool? scrollable,
      MainAlignment? mainAlignment,
      CrossAlignment? crossAlignment}) {
    return Settings(
        axis: axis ?? this.axis,
        scrollable: scrollable ?? this.scrollable,
        mainAlignment: mainAlignment ?? this.mainAlignment,
        crossAlignment: crossAlignment ?? this.crossAlignment);
  }
}
