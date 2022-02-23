import 'package:flutter/rendering.dart';

/// Parent data for use with [RenderAxisLayout].
class AxisLayoutParentData extends ContainerBoxParentData<RenderBox> {
  double expand = 0;
  double shrink = 0;
  int shrinkOrder = 0;
}
