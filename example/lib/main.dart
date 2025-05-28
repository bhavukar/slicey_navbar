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
      debugShowCheckedModeBanner: false,
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
  final controller = CarouselNavController();
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _DemoPage(
      title: 'Home',
      icon: Icons.home,
      backgroundColor: Colors.white,
    ),
    const _DemoPage(
      title: 'Search',
      icon: Icons.search,
      backgroundColor: Colors.white,
    ),
    const _DemoPage(
      title: 'Profile',
      icon: Icons.person,
      backgroundColor: Colors.white,
    ),
    _DemoPage(
      title: 'Settings',
      icon: Icons.settings,
      backgroundColor: Colors.white,
    ),
  ];

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        _selectedIndex = controller.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselNavScaffold(
      pages: _pages,
      navigationBar: CarouselNavBar(
        controller: controller,
        itemBackgroundColor: Colors.white,
        navBarBackgroundColor: Colors.transparent,
        shadowColor: Colors.black.withOpacity(0.1),
        iconColor: Colors.grey,
        selectedIconColor: Colors.black,
        scaleFactor: 1,
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

class _DemoPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;

  const _DemoPage({
    required this.title,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
