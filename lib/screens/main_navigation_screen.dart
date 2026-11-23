import 'package:material_ui/material_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';
import 'package:rijschool_app/screens/dashboard_screen.dart';
import 'package:rijschool_app/screens/lessons_screen.dart';
import 'package:rijschool_app/screens/pupils_screen.dart';
import 'package:rijschool_app/screens/settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {
  int currentIndex = 0;
  late Future<String?> _userRoleFuture;

  @override
  void initState() {
    super.initState();
    _userRoleFuture = _loadUserRole();
  }

  Future<String?> _loadUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final result = await ConnectorConnector.instance
        .getMyRole(firebaseUid: user.uid)
        .execute();

    final users = result.data.users;
    if (users.isEmpty) return null;

    return users.first.role;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _userRoleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Could not load user role')),
          );
        }

        final isAdmin = snapshot.data == 'ADMIN';
        final isInstructor = snapshot.data == 'INSTRUCTOR';

        final pages = <Widget>[
          const DashboardScreen(),
          const LessonsScreen(),
          if (isInstructor || isAdmin) const PupilsScreen(),
          const SettingsScreen(),
        ];

        // Keep the index valid if available tabs change.
        final safeIndex =
        currentIndex < pages.length ? currentIndex : 0;

        return Scaffold(
          body: pages[safeIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: safeIndex,
            onDestinationSelected: (index) {
              setState(() => currentIndex = index);
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              const NavigationDestination(
                icon: Icon(Icons.pending_actions_outlined),
                selectedIcon: Icon(Icons.pending_actions),
                label: 'Lessons',
              ),
              if (isInstructor || isAdmin)
              const NavigationDestination(
                icon: Icon(Icons.person_outlined),
                selectedIcon: Icon(Icons.person),
                label: 'Pupils',
              ),
              const NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}
