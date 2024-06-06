import 'package:flutter/material.dart';
import 'package:front/presentation/screens/add_patient_screen.dart';
import 'package:front/presentation/screens/procedures_screen.dart';
import 'package:front/presentation/screens/profile_screen.dart';
import 'package:front/theme.dart';

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
      const ProfileScreen(),
    ];

    final indicatorColor = seedColor.withAlpha(30);

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: widgetOptions,
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 20,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTap,
        indicatorColor: indicatorColor,

        destinations: const [
          NavigationDestination(icon: Icon(Icons.vaccines), label: 'Procedure'),
          NavigationDestination(icon: Icon(Icons.add_box), label: 'Dodaj pacijenta'),
          NavigationDestination(icon: Icon(Icons.account_circle), label: 'Nalog'),
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
