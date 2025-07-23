import 'package:flutter/widgets.dart';

class SlowScrollPhysics extends ClampingScrollPhysics {
  const SlowScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  SlowScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SlowScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // Reduce scroll speed by 60% (you can tune this value)
    return super.applyPhysicsToUserOffset(position, offset * 0.4);
  }
}
