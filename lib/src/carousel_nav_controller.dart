import 'package:flutter/foundation.dart';

/// Controller for managing the selected index in [CarouselNavBar].
///
/// This controller allows controlling the [CarouselNavBar] from outside
/// and synchronizes selection state with the nav bar.
class CarouselNavController extends ChangeNotifier {
  /// Current selected index in the navigation bar.
  int _index = 0;

  /// Gets the current selected index.
  int get index => _index;

  /// Creates a controller with an optional initial index.
  ///
  /// The [initialIndex] defaults to 0 if not provided.
  CarouselNavController({int initialIndex = 0}) : _index = initialIndex;

  /// Updates the selected index and notifies listeners.
  ///
  /// This will cause the [CarouselNavBar] to update its selected item.
  void setIndex(int value) {
    if (_index != value) {
      _index = value;
      notifyListeners();
    }
  }
}