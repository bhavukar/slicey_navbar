# Slicey NavBar

A beautiful, animated carousel-style navigation bar for Flutter applications.



## Features

- Smooth, carousel-style navigation experience
- Fully customizable appearance
- Animated icon transitions with scale effects
- Multiple animation types (linear, fade, scale, slide)
- Support for custom widgets as navigation items
- Built-in page transitions
- Swipeable navigation
- Controllable from outside with `CarouselNavController`
- Material Design inspired with customizable shadows

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  slicey_navbar: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
CarouselNavBar(
  items: [
    CarouselNavItem(icon: Icon(Icons.home)),
    CarouselNavItem(icon: Icon(Icons.search)),
    CarouselNavItem(icon: Icon(Icons.person)),
    CarouselNavItem(icon: Icon(Icons.settings)),
  ],
  onItemSelected: (index) {
    // Handle item selection
    print('Selected index: $index');
  },
)
```

### With Pages and Navigation

Use the `CarouselNavScaffold` for seamless integration with page content:

```dart
CarouselNavScaffold(
  navigationBar: CarouselNavBar(
    items: [
      CarouselNavItem(icon: Icon(Icons.home_outlined)),
      CarouselNavItem(icon: Icon(Icons.search)),
      CarouselNavItem(icon: Icon(Icons.person_outline)),
      CarouselNavItem(icon: Icon(Icons.settings_outlined)),
    ],
    selectedIconColor: Colors.blue,
    iconColor: Colors.grey,
    animationType: NavBarAnimationType.fade,
  ),
  pages: [
    HomePage(),
    SearchPage(),
    ProfilePage(),
    SettingsPage(),
  ],
)
```

### With Controller

```dart
final controller = CarouselNavController();

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: yourPageContent,
    bottomNavigationBar: CarouselNavBar(
      controller: controller,
      items: [
        CarouselNavItem(icon: Icon(Icons.home)),
        CarouselNavItem(icon: Icon(Icons.search)),
        CarouselNavItem(icon: Icon(Icons.person)),
      ],
    ),
  );
}

// Later, to programmatically change the selected tab:
controller.setIndex(1);

// Don't forget to dispose the controller:
@override
void dispose() {
  controller.dispose();
  super.dispose();
}
```

## Customization

### Available Properties

```dart
CarouselNavBar(
  items: yourItems,
  iconSize: 24,                             // Size of the navigation icons
  scaleFactor: 1.2,                         // Scale factor for selected item
  backgroundColor: Colors.white,            // Background color for items
  iconColor: Colors.grey,                   // Color for unselected icons
  selectedIconColor: Colors.blue,           // Color for selected icon
  selectedBackgroundColor: Colors.white,    // Background for selected item
  shadowColor: Colors.black12,              // Color of the shadow
  showShadow: true,                         // Whether to show shadows
  animationType: NavBarAnimationType.linear, // Animation type
  animationDurationMs: 300,                 // Duration for animations
  controller: yourController,               // External controller
  enableSwipe: true,                        // Enable swipe navigation
  pages: yourPages,                         // Pages to display (optional)
  onItemSelected: (index) { },              // Selection callback
)
```

### Animation Types

Choose between different animation types:

- `NavBarAnimationType.linear` - No special animation between pages
- `NavBarAnimationType.fade` - Fade transition between pages
- `NavBarAnimationType.scale` - Scale transition between pages
- `NavBarAnimationType.slide` - Slide transition between pages

## Example

```dart
import 'package:flutter/material.dart';
import 'package:slicey_navbar/slicey_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slicey NavBar Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const NavBarDemo(),
    );
  }
}

class NavBarDemo extends StatefulWidget {
  const NavBarDemo({super.key});

  @override
  State<NavBarDemo> createState() => _NavBarDemoState();
}

class _NavBarDemoState extends State<NavBarDemo> {
  final CarouselNavController controller = CarouselNavController();
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Search Page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Settings Page', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slicey NavBar Example'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CarouselNavBar(
        controller: controller,
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.1),
        iconColor: Colors.grey,
        selectedIconColor: Colors.blue,
        scaleFactor: 1.2,
        iconSize: 26,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          CarouselNavItem(icon: const Icon(Icons.home_outlined)),
          CarouselNavItem(icon: const Icon(Icons.search)),
          CarouselNavItem(icon: const Icon(Icons.person_outline)),
          CarouselNavItem(icon: const Icon(Icons.settings_outlined)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
```

## Contributions

Contributions are welcome! If you find any issues or want to contribute, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.