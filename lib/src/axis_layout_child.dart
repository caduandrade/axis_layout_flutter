import 'dart:math' as math;

import 'package:axis_layout/src/axis_layout.dart';
import 'package:axis_layout/src/parent_data.dart';
import 'package:flutter/widgets.dart';

class AxisLayoutChild extends ParentDataWidget<AxisLayoutParentData> {
  const AxisLayoutChild({
    Key? key,
    this.expand = 0,
    this.shrink = 0,
    this.shrinkOrder = 0,
    required Widget child,
  }) : super(key: key, child: child);

  /// The expand weight
  final double expand;

  /// Value between 0 (no shrinkage) and 1 (full shrinkage) to indicate
  /// the shrinkage fraction.
  final double shrink;
  final int shrinkOrder;

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is AxisLayoutParentData);
    final AxisLayoutParentData parentData =
        renderObject.parentData! as AxisLayoutParentData;
    bool needsLayout = false;

    if (parentData.expand != expand) {
      parentData.expand = expand;
      needsLayout = true;
    }

    double validShrink = math.min(1, math.max(0, shrink));
    if (parentData.shrink != validShrink) {
      parentData.shrink = validShrink;
      needsLayout = true;
    }

    if (parentData.shrinkOrder != shrinkOrder) {
      parentData.shrinkOrder = shrinkOrder;
      needsLayout = true;
    }

    if (needsLayout) {
      final RenderObject? targetParent = renderObject.parent;
      targetParent?.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => AxisLayout;
}
