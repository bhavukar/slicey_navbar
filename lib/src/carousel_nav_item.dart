import 'package:flutter/material.dart';

import 'carousel_nav_bar_widget.dart';
import 'carousel_nav_controller.dart';

/// Animation type for page transitions
enum NavBarAnimationType {
  /// Linear transition between pages
  linear,

  /// Fade transition between pages
  fade,

  /// Scale transition between pages
  scale,

  /// Slide transition between pages
  slide,
}

/// A beautiful, animated carousel-style navigation bar.
///
/// The [CarouselNavBar] displays navigation items in a horizontal scrollable bar
/// with animations when selecting items. Each item grows when selected and
/// provides visual feedback.
class CarouselNavBar extends StatefulWidget {
  /// The list of navigation items to display.
  ///
  /// Must have at least 2 items.
  final List<CarouselNavItem> items;

  /// The size of the icons in the navigation bar.
  final double iconSize;

  /// The scale factor applied to items when selected.
  ///
  /// A value of 1.0 means no scaling, while larger values increase the size.
  final double scaleFactor;

  /// The background color of the navigation items.
  final Color navBarBackgroundColor;

  /// The background color of the navigation items.
  final Color itemBackgroundColor;

  /// The color of all icons when not selected.
  final Color? iconColor;

  /// The color of the selected icon.
  final Color? selectedIconColor;

  /// The background color of the selected item.
  final Color? selectedBackgroundColor;

  /// The color of the shadow below navigation items.
  final Color shadowColor;

  /// Whether to show shadows under the navigation items.
  final bool showShadow;

  /// Animation type for page transitions.
  final NavBarAnimationType animationType;

  /// Duration for animations in milliseconds.
  final int animationDurationMs;

  /// Optional controller to manage the selected index from outside.
  final CarouselNavController? controller;

  /// Whether the body content should be swipeable.
  final bool enableSwipe;

  /// List of pages to display in the body.
  final List<Widget>? pages;

  /// Callback that gets called when a navigation item is selected.
  final void Function(int index)? onItemSelected;

  /// Creates a carousel navigation bar.
  ///
  /// The [items] parameter must contain at least 2 navigation items.
  const CarouselNavBar({
    super.key,
    required this.items,
    this.iconSize = 24,
    this.scaleFactor = 1.2,
    this.itemBackgroundColor = Colors.white,
    this.iconColor,
    this.selectedIconColor,
    this.navBarBackgroundColor = Colors.white,
    this.selectedBackgroundColor,
    this.shadowColor = Colors.black12,
    this.showShadow = true,
    this.animationType = NavBarAnimationType.linear,
    this.animationDurationMs = 300,
    this.controller,
    this.enableSwipe = true,
    this.pages,
    this.onItemSelected,
  }) : assert(items.length >= 2, 'At least 2 items required'),
       assert(
         pages == null || pages.length == items.length,
         'Number of pages must match number of nav items',
       );

  @override
  State<CarouselNavBar> createState() => _CarouselNavBarState();
}

class _CarouselNavBarState extends State<CarouselNavBar> {
  PageController? _navController;
  PageController? _pageController;
  late int _selectedIndex;
  CarouselNavController? get _externalController => widget.controller;

  @override
  void initState() {
    super.initState();
    _selectedIndex = _externalController?.index ?? 0;
    _navController = PageController(
      initialPage: _selectedIndex,
      viewportFraction: 0.25,
    );

    if (widget.pages != null) {
      _pageController = PageController(initialPage: _selectedIndex);
    }

    _externalController?.addListener(() {
      if (_externalController!.index != _selectedIndex) {
        _onItemTapped(_externalController!.index);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    _navController?.animateToPage(
      index,
      duration: Duration(milliseconds: widget.animationDurationMs),
      curve: Curves.easeInOut,
    );

    if (_pageController != null) {
      _pageController!.animateToPage(
        index,
        duration: Duration(milliseconds: widget.animationDurationMs),
        curve: Curves.easeInOut,
      );
    }

    widget.onItemSelected?.call(index);
    _externalController?.setIndex(index);
    widget.items[index].onTap?.call();
  }

  void _onPageChanged(int index) {
    if (index != _selectedIndex) {
      _onItemTapped(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _navController,
      itemCount: widget.items.length,
      physics: widget.enableSwipe
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      onPageChanged: _onPageChanged,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final bool isSelected = index == _selectedIndex;

        // Apply icon color if specified
        Widget iconWidget = item.icon;
        if (iconWidget is Icon &&
            (widget.iconColor != null || widget.selectedIconColor != null)) {
          final Icon icon = iconWidget;
          iconWidget = Icon(
            icon.icon,
            size: icon.size ?? widget.iconSize,
            color: isSelected
                ? widget.selectedIconColor ?? icon.color
                : widget.iconColor ?? icon.color,
          );
        }

        return GestureDetector(
          onTap: () => _onItemTapped(index),
          child: AnimatedScale(
            scale: isSelected ? widget.scaleFactor : 0.9,
            duration: Duration(milliseconds: widget.animationDurationMs),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isSelected
                    ? widget.selectedBackgroundColor ??
                          widget.itemBackgroundColor
                    : widget.itemBackgroundColor,
                shape: BoxShape.circle,
                boxShadow: widget.showShadow
                    ? [
                        BoxShadow(
                          color: widget.shadowColor,
                          blurRadius: 25,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: SizedBox(
                width: widget.iconSize,
                height: widget.iconSize,
                child: Center(child: iconWidget),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _navController?.dispose();
    _pageController?.dispose();
    super.dispose();
  }
}

/// Creates a widget that combines the navigation bar with content pages.
///
/// This wraps the CarouselNavBar and its associated page content.
class CarouselNavScaffold extends StatefulWidget {
  /// The navigation bar for this scaffold
  final CarouselNavBar navigationBar;

  /// Pages to display in the body
  final List<Widget> pages;

  /// Creates a scaffold with a CarouselNavBar
  CarouselNavScaffold({
    super.key,
    required this.navigationBar,
    required this.pages,
  }) : assert(
         navigationBar.items.length == pages.length,
         'Number of pages must match number of nav items',
       );

  @override
  State<CarouselNavScaffold> createState() => _CarouselNavScaffoldState();
}

class _CarouselNavScaffoldState extends State<CarouselNavScaffold> {
  PageController? _pageController;
  late CarouselNavController _navController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _navController = widget.navigationBar.controller ?? CarouselNavController();
    _selectedIndex = _navController.index;
    _pageController = PageController(initialPage: _selectedIndex);

    _navController.addListener(() {
      if (_navController.index != _selectedIndex) {
        setState(() => _selectedIndex = _navController.index);
        _pageController?.animateToPage(
          _selectedIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Widget _buildPageTransition(BuildContext context, int index) {
    final page = widget.pages[index];
    final animationType = widget.navigationBar.animationType;
    final isCurrentPage = index == _selectedIndex;

    switch (animationType) {
      case NavBarAnimationType.fade:
        return AnimatedOpacity(
          opacity: isCurrentPage ? 1.0 : 0.0,
          duration: Duration(
            milliseconds: widget.navigationBar.animationDurationMs,
          ),
          child: page,
        );

      case NavBarAnimationType.scale:
        return AnimatedScale(
          scale: isCurrentPage ? 1.0 : 0.8,
          duration: Duration(
            milliseconds: widget.navigationBar.animationDurationMs,
          ),
          child: page,
        );

      case NavBarAnimationType.slide:
        return AnimatedSlide(
          offset: isCurrentPage ? Offset.zero : const Offset(0.1, 0),
          duration: Duration(
            milliseconds: widget.navigationBar.animationDurationMs,
          ),
          child: page,
        );

      case NavBarAnimationType.linear:
        return page;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        controller: _pageController,
        physics: widget.navigationBar.enableSwipe
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: widget.pages.length,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
          _navController.setIndex(index);
        },
        itemBuilder: (context, index) => _buildPageTransition(context, index),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        height: kBottomNavigationBarHeight + 100, // Add some padding
        color: widget.navigationBar.navBarBackgroundColor,
        child: widget.navigationBar,
      ),
    );
  }

  @override
  void dispose() {
    // Only dispose if we created the controller
    if (widget.navigationBar.controller == null) {
      _navController.dispose();
    }
    _pageController?.dispose();
    super.dispose();
  }
}
