import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget{
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const Text('Index 0: Procedures'),
    const Text('Index 1: Add patient'),
    const Text('Index 2: Profile?'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTap,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.vaccines), label: 'Procedures',),
          NavigationDestination(icon: Icon(Icons.add), label: 'Add patient'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile?'),
        ],
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}