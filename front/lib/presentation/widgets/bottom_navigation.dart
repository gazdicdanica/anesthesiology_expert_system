import 'package:flutter/material.dart';
import 'package:front/presentation/screens/add_patient_screen.dart';
import 'package:front/presentation/screens/procedures_screen.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const ProceduresScreen(),
      AddPatientScreen(
        onAddPatientTap: _onItemTap,
      ),
      const Text('Index 2: Profile?'),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: widgetOptions,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTap,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.vaccines),
            label: 'Procedure',
          ),
          NavigationDestination(icon: Icon(Icons.add), label: 'Dodaj pacijenta'),
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
