import 'package:flutter/widgets.dart';

/// A navigation item to be used within [CarouselNavBar].
///
/// Each item represents a tab in the navigation bar and consists of an icon
/// and an optional tap callback.
class CarouselNavItem {
  /// The widget to display as the navigation item's icon.
  ///
  /// Typically an [Icon] widget, but can be any widget.
  final Widget icon;

  /// Callback that gets called when this navigation item is tapped.
  ///
  /// If provided, this will be called in addition to the [CarouselNavBar]'s
  /// global selection callback.
  final VoidCallback? onTap;

  /// Creates a navigation item for [CarouselNavBar].
  ///
  /// The [icon] parameter is required and represents the visual element
  /// of the navigation item.
  CarouselNavItem({required this.icon, this.onTap});
}