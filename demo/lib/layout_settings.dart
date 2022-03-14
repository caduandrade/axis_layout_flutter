import 'package:axis_layout/axis_layout.dart';
import 'package:flutter/widgets.dart';

class LayoutSettings {
  LayoutSettings(
      {required this.axis,
      required this.mainAlignment,
      required this.crossAlignment,
      required this.antiAliasingBugWorkaround,
      required this.clip});

  final Axis axis;
  final MainAlignment mainAlignment;
  final CrossAlignment crossAlignment;
  final bool antiAliasingBugWorkaround;
  final Clip clip;

  /// Creates a copy of this settings but with the given fields replaced with the new values.
  LayoutSettings copyWith(
      {Axis? axis,
      bool? scrollable,
      MainAlignment? mainAlignment,
      CrossAlignment? crossAlignment,
      bool? antiAliasingBugWorkaround,
      Clip? clip}) {
    return LayoutSettings(
        axis: axis ?? this.axis,
        mainAlignment: mainAlignment ?? this.mainAlignment,
        crossAlignment: crossAlignment ?? this.crossAlignment,
        antiAliasingBugWorkaround:
            antiAliasingBugWorkaround ?? this.antiAliasingBugWorkaround,
        clip: clip ?? this.clip);
  }
}
