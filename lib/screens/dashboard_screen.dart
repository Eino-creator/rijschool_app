
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';
import 'package:rijschool_app/screens/lessons_screen.dart';
import 'package:rijschool_app/screens/pupils_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  bool _isCreatingProfile = false;

  Future<void> _createMyProfile() async {
    setState(() => _isCreatingProfile = true);

  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
      const LessonsScreen(),
      const PupilsScreen(),
    ];

    const pageTitles = [
      'Dashboard',
      'Lessons',
      'Pupils',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitles[currentIndex]),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.pending_actions_outlined),
            selectedIcon: Icon(Icons.pending_actions),
            label: 'Lessons',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Pupils',
          ),
        ],
      ),
    );
  }
}
