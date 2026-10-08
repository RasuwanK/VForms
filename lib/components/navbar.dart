import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key,required this.setScreen, required this.currentScreen});

  final void Function(int) setScreen;
  final int currentScreen;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NavbarState();
  }
}

class _NavbarState extends State<Navbar> {
  // Track the active index

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: widget.currentScreen,
      onDestinationSelected: (int index) {
        widget.setScreen(index);
      },
      indicatorColor: const Color(0xFF4687E1),
      destinations: const <NavigationDestination>[
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.folder), label: 'Forms'),
        NavigationDestination(icon: Icon(Icons.account_circle), label: 'Profile')
      ],
    );
  }
}
