/// How the children should be placed along the cross axis in a layout.
///
/// Inspired by Flutter [CrossAxisAlignment]
enum CrossAlignment {
  /// Place the children with their start edge aligned with the start side of
  /// the cross axis.
  start,

  /// Place the children as close to the end of the cross axis as possible.
  end,

  /// Place the children so that their centers align with the middle of the
  /// cross axis.
  ///
  /// This is the default cross-axis alignment.
  center,

  /// Require the children to fill the cross axis.
  ///
  /// This causes the constraints passed to the children to be tight in the
  /// cross axis.
  stretch
}
