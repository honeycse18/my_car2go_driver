import 'dart:async';

import 'package:car2godriver/utils/libraries/debouncer/behaviour_type.dart';

/// The `Debouncer` class provides a mechanism to debounce function calls,
/// ensuring that the function is only invoked after a specified duration of
/// inactivity.
class Debouncer {
  Timer? _debounceTimer;

  /// Debounces the provided [callback] function by canceling any existing
  /// timer and scheduling a new timer to invoke the callback after the
  /// specified [duration] of inactivity.
  ///
  /// The [callback] function is invoked only once, even if this method is
  /// called multiple times within the [duration].
  ///
  /// The [type] parameter specifies the debounce behavior. Use [BehaviorType.trailingEdge]
  /// to execute the [onDebounce] function after the [duration] has passed without
  /// any new calls. Use [BehaviorType.leadingEdge] to execute the [onDebounce]
  /// function immediately on the first call and postpone any subsequent calls
  /// within the [duration]. Use [BehaviorType.leadingAndTrailing] to execute
  /// the [onDebounce] function both on the leading and trailing edges of the
  /// timer.
  void debounce({
    required Duration duration,
    required Function() onDebounce,
    BehaviorType type = BehaviorType.trailingEdge,
  }) {
    if (type == BehaviorType.leadingEdge ||
        type == BehaviorType.leadingAndTrailing) {
      onDebounce();
    }

    _debounceTimer?.cancel();
    _debounceTimer = Timer(duration, () {
      if (type == BehaviorType.trailingEdge ||
          type == BehaviorType.leadingAndTrailing) {
        onDebounce();
      }
    });
  }

  /// Cancels any pending debounced callbacks.
  ///
  /// If there is an active debounce timer, it will be canceled, and the
  /// debounced callback associated with that timer will not be invoked.
  void cancel() {
    _debounceTimer?.cancel();
  }
}
