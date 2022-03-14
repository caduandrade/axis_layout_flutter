import 'dart:math' as math;
import 'package:axis_layout/src/cross_alignment.dart';
import 'package:axis_layout/src/main_alignment.dart';
import 'package:axis_layout/src/parent_data.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Axis layout with grow and shrink features.
///
/// Inspired by [Flex],[Row] and [Column] Flutter layouts.
class AxisLayout extends MultiChildRenderObjectWidget {
  AxisLayout(
      {Key? key,
      required this.axis,
      required List<Widget> children,
      this.clipBehavior = Clip.none,
      this.antiAliasingBugWorkaround = false,
      this.mainAlignment = MainAlignment.start,
      this.crossAlignment = CrossAlignment.center})
      : super(key: key, children: children);

  final Axis axis;

  /// Enables a workaround for https://github.com/flutter/flutter/issues/14288
  final bool antiAliasingBugWorkaround;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;
  final MainAlignment mainAlignment;
  final CrossAlignment crossAlignment;

  @override
  RenderAxisLayout createRenderObject(BuildContext context) {
    return RenderAxisLayout(
        direction: axis,
        mainAxisAlignment: mainAlignment,
        crossAxisAlignment: crossAlignment,
        clipBehavior: clipBehavior,
        antiAliasingBugWorkaround: antiAliasingBugWorkaround);
  }

  @override
  MultiChildRenderObjectElement createElement() => _AxisLayoutElement(this);

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderAxisLayout renderObject) {
    renderObject
      ..axis = axis
      ..mainAlignment = mainAlignment
      ..crossAlignment = crossAlignment
      ..clipBehavior = clipBehavior
      ..antiAliasingBugWorkaround = antiAliasingBugWorkaround;
  }
}

class _AxisLayoutElement extends MultiChildRenderObjectElement {
  _AxisLayoutElement(AxisLayout widget) : super(widget);

  @override
  void debugVisitOnstageChildren(ElementVisitor visitor) {
    for (var child in children) {
      if (child.renderObject != null) {
        visitor(child);
      }
    }
  }
}

/// [AxisLayout] render.
///
/// Inspired by [RenderFlex].
class RenderAxisLayout extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, AxisLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, AxisLayoutParentData>,
        DebugOverflowIndicatorMixin {
  RenderAxisLayout(
      {required Axis direction,
      required MainAlignment mainAxisAlignment,
      required CrossAlignment crossAxisAlignment,
      required Clip clipBehavior,
      required bool antiAliasingBugWorkaround})
      : _axis = direction,
        _mainAlignment = mainAxisAlignment,
        _crossAlignment = crossAxisAlignment,
        _clipBehavior = clipBehavior,
        _antiAliasingBugWorkaround = antiAliasingBugWorkaround;

  Axis _axis;
  set axis(Axis value) {
    if (_axis != value) {
      _axis = value;
      markNeedsLayout();
    }
  }

  MainAlignment _mainAlignment;
  set mainAlignment(MainAlignment value) {
    if (_mainAlignment != value) {
      _mainAlignment = value;
      markNeedsLayout();
    }
  }

  CrossAlignment _crossAlignment;
  set crossAlignment(CrossAlignment value) {
    if (_crossAlignment != value) {
      _crossAlignment = value;
      markNeedsLayout();
    }
  }

  bool _antiAliasingBugWorkaround;
  set antiAliasingBugWorkaround(bool value) {
    if (_antiAliasingBugWorkaround != value) {
      _antiAliasingBugWorkaround = value;
      markNeedsLayout();
    }
  }

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none], and must not be null.
  Clip _clipBehavior = Clip.none;
  set clipBehavior(Clip value) {
    if (value != _clipBehavior) {
      _clipBehavior = value;
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! AxisLayoutParentData) {
      child.parentData = AxisLayoutParentData();
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    double value = 0;
    visitChildren((child) {
      final double childWidth =
          (child as RenderBox).getMinIntrinsicWidth(height);
      if (_axis == Axis.horizontal) {
        value = value + childWidth;
      } else {
        value = math.max(value, childWidth);
      }
    });
    return value;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    double value = 0;
    visitChildren((child) {
      final double childWidth =
          (child as RenderBox).getMaxIntrinsicWidth(height);
      if (_axis == Axis.horizontal) {
        value += childWidth;
      } else {
        value = math.max(value, childWidth);
      }
      value++;
    });
    return value;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    double value = 0;
    visitChildren((child) {
      final double childHeight =
          (child as RenderBox).getMinIntrinsicHeight(width);
      if (_axis == Axis.horizontal) {
        value = math.max(value, childHeight);
      } else {
        value = value + childHeight;
      }
    });
    return value;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    double value = 0;
    visitChildren((child) {
      final double childHeight =
          (child as RenderBox).getMaxIntrinsicHeight(width);
      if (_axis == Axis.horizontal) {
        value = math.max(value, childHeight);
      } else {
        value = value + childHeight;
      }
    });
    return value;
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    if (_axis == Axis.horizontal) {
      return defaultComputeDistanceToHighestActualBaseline(baseline);
    }
    return defaultComputeDistanceToFirstActualBaseline(baseline);
  }

  double _getCrossSize(Size size) {
    switch (_axis) {
      case Axis.horizontal:
        return size.height;
      case Axis.vertical:
        return size.width;
    }
  }

  double _getMainSize(Size size) {
    switch (_axis) {
      case Axis.horizontal:
        return size.width;
      case Axis.vertical:
        return size.height;
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final _LayoutSizes sizes = _computeSizes(
      layoutChild: ChildLayoutHelper.dryLayoutChild,
      constraints: constraints,
    );

    /*
    if (_axis == Axis.horizontal) {
      return Size(sizes.mainSize, sizes.crossSize);
    }
    return Size(sizes.crossSize, sizes.mainSize);
     */

    switch (_axis) {
      case Axis.horizontal:
        return constraints.constrain(Size(sizes.mainSize, sizes.crossSize));
      case Axis.vertical:
        return constraints.constrain(Size(sizes.crossSize, sizes.mainSize));
    }
  }

  _LayoutSizes _computeSizes(
      {required BoxConstraints constraints,
      required ChildLayouter layoutChild}) {
    List<RenderBox> children = [];
    visitChildren((child) => children.add(child as RenderBox));

    final double maxMainSize =
        _axis == Axis.horizontal ? constraints.maxWidth : constraints.maxHeight;

    final double maxCrossSize =
        _axis == Axis.horizontal ? constraints.maxHeight : constraints.maxWidth;

    double totalExpand = 0;
    double totalShrink = 0;
    double maxUsedCrossSize = 0;
    double totalUsedMainSize = 0;
    for (RenderBox child in children) {
      final AxisLayoutParentData parentData = child.axisLayoutParentData();
      Size childSize;
      if (_axis == Axis.horizontal) {
        if (parentData.expand > 0) {
          childSize = layoutChild(
              child,
              BoxConstraints(
                  minWidth: 0, maxWidth: 0, maxHeight: constraints.maxHeight));
        } else {
          childSize = layoutChild(
              child, BoxConstraints(maxHeight: constraints.maxHeight));
        }
      } else {
        if (parentData.expand > 0) {
          childSize = layoutChild(
              child,
              BoxConstraints(
                  maxWidth: constraints.maxWidth, minHeight: 0, maxHeight: 0));
        } else {
          childSize = layoutChild(
              child, BoxConstraints(maxWidth: constraints.maxWidth));
        }
      }
      double mainChildSize = _getMainSize(childSize);
      totalUsedMainSize += mainChildSize;

      maxUsedCrossSize = math.max(maxUsedCrossSize, _getCrossSize(childSize));

      totalExpand += parentData.expand;
      if (parentData.expand == 0) {
        totalShrink += parentData.shrink;
      }
    }

    if (maxMainSize < double.infinity) {
      if (totalShrink > 0) {
        double totalOverflowSize = math.max(0, totalUsedMainSize - maxMainSize);
        if (totalOverflowSize > 0) {
          List<RenderBox> shrinkableChildren = [];
          for (RenderBox child in children) {
            AxisLayoutParentData parentData = child.axisLayoutParentData();
            if (parentData.expand == 0 && parentData.shrink > 0) {
              shrinkableChildren.add(child);
            }
          }
          shrinkableChildren.sort((a, b) => a
              .axisLayoutParentData()
              .shrinkOrder
              .compareTo(b.axisLayoutParentData().shrinkOrder));

          for (int i = 0;
              i < shrinkableChildren.length && totalOverflowSize > 0;
              i++) {
            RenderBox child = shrinkableChildren[i];
            final double shrink = child.axisLayoutParentData().shrink;
            final double childMainSize = _getMainSize(child.size);
            final double disposableChildMainSize = childMainSize * shrink;

            if (disposableChildMainSize > totalOverflowSize) {
              _tightToNewMainSize(
                  child: child,
                  size: childMainSize - totalOverflowSize,
                  maxCrossSize: maxCrossSize,
                  layoutChild: layoutChild);
              totalUsedMainSize -= totalOverflowSize;
              totalOverflowSize = 0;
            } else {
              _tightToNewMainSize(
                  child: child,
                  size: childMainSize - disposableChildMainSize,
                  maxCrossSize: maxCrossSize,
                  layoutChild: layoutChild);
              totalOverflowSize -= disposableChildMainSize;
              totalUsedMainSize -= disposableChildMainSize;
            }
          }

          maxUsedCrossSize = 0;
          for (RenderBox child in children) {
            maxUsedCrossSize =
                math.max(maxUsedCrossSize, _getCrossSize(child.size));
          }
        }
      }

      if (totalExpand > 0) {
        double remainingMainSize = math.max(0, maxMainSize - totalUsedMainSize);
        if (remainingMainSize > 0) {
          double widthPerExpand = remainingMainSize / totalExpand;
          for (RenderBox child in children) {
            final double expand = child.axisLayoutParentData().expand;
            final double extraMainSize = widthPerExpand * expand;
            final double newChildMainSize =
                _getMainSize(child.size) + extraMainSize;
            _tightToNewMainSize(
                child: child, size: newChildMainSize, layoutChild: layoutChild);
            totalUsedMainSize += extraMainSize;
          }
        }
      }
    }

    if (_crossAlignment == CrossAlignment.stretch) {
      for (RenderBox child in children) {
        if (_axis == Axis.horizontal) {
          layoutChild(
              child,
              BoxConstraints.tightFor(
                  width: child.size.width, height: maxUsedCrossSize));
        } else {
          layoutChild(
              child,
              BoxConstraints.tightFor(
                  width: maxUsedCrossSize, height: child.size.height));
        }
      }
    }

    if (_antiAliasingBugWorkaround) {
      totalUsedMainSize = 0;
      for (int i = 0; i < children.length; i++) {
        RenderBox child = children[i];
        double newChildMainSize = _getMainSize(child.size);
        newChildMainSize = newChildMainSize.roundToDouble();
        _tightToNewMainSize(
            child: child, size: newChildMainSize, layoutChild: layoutChild);
        totalUsedMainSize += newChildMainSize;
      }
    }

    final double mainSize;
    if (_axis == Axis.horizontal) {
      mainSize = math.max(math.min(totalUsedMainSize, constraints.maxWidth),
          constraints.minWidth);
    } else {
      mainSize = math.max(math.min(totalUsedMainSize, constraints.maxHeight),
          constraints.minHeight);
    }

    return _LayoutSizes(
      mainSize: mainSize,
      crossSize: maxUsedCrossSize,
      usedSize: totalUsedMainSize,
    );
  }

  void _tightToNewMainSize(
      {required RenderBox child,
      required double size,
      double? maxCrossSize,
      required ChildLayouter layoutChild}) {
    if (_axis == Axis.horizontal) {
      if (maxCrossSize != null) {
        layoutChild(
            child,
            BoxConstraints(
                minWidth: size, maxWidth: size, maxHeight: maxCrossSize));
      } else {
        layoutChild(child,
            BoxConstraints.tightFor(width: size, height: child.size.height));
      }
    } else {
      if (maxCrossSize != null) {
        layoutChild(
            child,
            BoxConstraints(
                maxWidth: maxCrossSize, minHeight: size, maxHeight: size));
      } else {
        layoutChild(child,
            BoxConstraints.tightFor(width: child.size.width, height: size));
      }
    }
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;

    final _LayoutSizes sizes = _computeSizes(
      layoutChild: ChildLayoutHelper.layoutChild,
      constraints: constraints,
    );

    List<RenderBox> children = [];
    visitChildren((child) => children.add(child as RenderBox));

    final double usedSize = sizes.usedSize;
    double actualSize = sizes.mainSize;
    double crossSize = sizes.crossSize;

    // Align items along the main axis.
    switch (_axis) {
      case Axis.horizontal:
        size = constraints.constrain(Size(actualSize, crossSize));
        actualSize = size.width;
        crossSize = size.height;
        break;
      case Axis.vertical:
        size = constraints.constrain(Size(crossSize, actualSize));
        actualSize = size.height;
        crossSize = size.width;
        break;
    }

    /*
    if (_axis == Axis.horizontal) {
      size = Size(sizes.mainSize, sizes.crossSize);
    } else {
      size = Size(sizes.crossSize, sizes.mainSize);
    }*/

    final double actualSizeDelta = actualSize - usedSize;
    final double remainingSpace = math.max(0.0, actualSizeDelta);
    late final double leadingSpace;
    late final double betweenSpace;
    switch (_mainAlignment) {
      case MainAlignment.start:
        leadingSpace = 0.0;
        betweenSpace = 0.0;
        break;
      case MainAlignment.end:
        leadingSpace = remainingSpace;
        betweenSpace = 0.0;
        break;
      case MainAlignment.center:
        leadingSpace = remainingSpace / 2.0;
        betweenSpace = 0.0;
        break;
      case MainAlignment.spaceBetween:
        leadingSpace = 0.0;
        betweenSpace = childCount > 1 ? remainingSpace / (childCount - 1) : 0.0;
        break;
      case MainAlignment.spaceAround:
        betweenSpace = childCount > 0 ? remainingSpace / childCount : 0.0;
        leadingSpace = betweenSpace / 2.0;
        break;
      case MainAlignment.spaceEvenly:
        betweenSpace = childCount > 0 ? remainingSpace / (childCount + 1) : 0.0;
        leadingSpace = betweenSpace;
        break;
    }

    // Position elements
    double childMainPosition = leadingSpace;
    for (RenderBox child in children) {
      final AxisLayoutParentData childParentData =
          child.parentData! as AxisLayoutParentData;
      final double childCrossPosition;
      switch (_crossAlignment) {
        case CrossAlignment.start:
          childCrossPosition = 0;
          break;
        case CrossAlignment.end:
          childCrossPosition = crossSize - _getCrossSize(child.size);
          break;
        case CrossAlignment.center:
          childCrossPosition =
              crossSize / 2.0 - _getCrossSize(child.size) / 2.0;
          break;
        case CrossAlignment.stretch:
          childCrossPosition = 0.0;
          break;
      }
      switch (_axis) {
        case Axis.horizontal:
          childParentData.offset =
              Offset(childMainPosition, childCrossPosition);
          break;
        case Axis.vertical:
          childParentData.offset =
              Offset(childCrossPosition, childMainPosition);
          break;
      }

      childMainPosition += _getMainSize(child.size) + betweenSpace;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_antiAliasingBugWorkaround) {
      offset = Offset(offset.dx.roundToDouble(), offset.dy.roundToDouble());
    }
    if (size.isEmpty) {
      return;
    }
    if (_clipBehavior == Clip.none) {
      _clipRectLayer.layer = null;
      defaultPaint(context, offset);
    } else {
      _clipRectLayer.layer = context.pushClipRect(
        needsCompositing,
        offset,
        Offset.zero & size,
        defaultPaint,
        clipBehavior: _clipBehavior,
        oldLayer: _clipRectLayer.layer,
      );
    }
  }

  final LayerHandle<ClipRectLayer> _clipRectLayer =
      LayerHandle<ClipRectLayer>();

  @override
  void dispose() {
    _clipRectLayer.layer = null;
    super.dispose();
  }

  @override
  Rect? describeApproximatePaintClip(RenderObject child) => Offset.zero & size;
}

class _LayoutSizes {
  const _LayoutSizes({
    required this.mainSize,
    required this.crossSize,
    required this.usedSize,
  });

  final double mainSize;
  final double crossSize;
  final double usedSize;
}

/// Utility extension to facilitate obtaining parent data.
extension _AxisLayoutParentDataGetter on RenderObject {
  AxisLayoutParentData axisLayoutParentData() {
    return parentData as AxisLayoutParentData;
  }
}
