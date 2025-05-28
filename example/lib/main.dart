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
    const _DemoPage(
      title: 'Home',
      icon: Icons.home,
    ),
    const _DemoPage(
      title: 'Search',
      icon: Icons.search,
    ),
    const _DemoPage(
      title: 'Profile',
      icon: Icons.person,
    ),
     _DemoPage(
      title: 'Settings',
      icon: Icons.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: CarouselNavBar(
          controller: controller,
          backgroundColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.1),
          scaleFactor: 1,
          iconSize: 26,
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            CarouselNavItem(
              icon: const Icon(Icons.home_outlined),
            ),
            CarouselNavItem(
              icon: const Icon(Icons.search),
            ),
            CarouselNavItem(
              icon: const Icon(Icons.person_outline),
            ),
            CarouselNavItem(
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
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

  const _DemoPage({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }
}