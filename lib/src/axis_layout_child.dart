import 'dart:math' as math;
import 'package:axis_layout/src/axis_layout.dart';
import 'package:axis_layout/src/parent_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AxisLayoutChild extends ParentDataWidget<AxisLayoutParentData> {
  const AxisLayoutChild({
    Key? key,
    this.fill = 0,
    this.fit = 0,
    this.shrink = 0,
    required Widget child,
  }) : super(key: key, child: child);

  final double fill;
  final double fit;

  /// 0 is no shrink and 1 is full shrink, zero as min size.
  final double shrink;

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is AxisLayoutParentData);
    final AxisLayoutParentData parentData =
        renderObject.parentData! as AxisLayoutParentData;
    bool needsLayout = false;

    if (parentData.fill != fill) {
      parentData.fill = fill;
      needsLayout = true;
    }

    double validShrink = math.min(1, math.max(0, shrink));
    if (parentData.shrink != validShrink) {
      parentData.shrink = validShrink;
      needsLayout = true;
    }

    if (parentData.fit != fit) {
      parentData.fit = fit;
      needsLayout = true;
    }

    if (needsLayout) {
      final AbstractNode? targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => AxisLayout;
}
