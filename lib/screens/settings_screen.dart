import 'package:material_ui/material_ui.dart';
import 'package:rijschool_app/screens/course_costs_screen.dart';
import 'package:rijschool_app/widgets/logout_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: ListTile(
              leading: const Icon(Icons.euro_symbol),
              title: const Text('Course Costs & Pricing'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CourseCostsScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: LogoutButton(),
          ),
        ],
      ),
    );
  }
}
