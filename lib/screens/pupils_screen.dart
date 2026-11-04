import 'package:flutter/material.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';
import 'package:rijschool_app/screens/pupil_screen.dart';

class PupilsScreen extends StatefulWidget {
  const PupilsScreen({super.key});

  @override
  State<PupilsScreen> createState() => _PupilsScreenState();
}

class _PupilsScreenState extends State<PupilsScreen> {
  late Future<dynamic> _pupilsFuture;

  @override
  void initState() {
    super.initState();
    _loadPupils();
  }

  void _loadPupils() {
    _pupilsFuture = ConnectorConnector.instance.getPupils().execute();
  }

  Future<void> _addPupil() async {
    // Show the self-contained dialog widget
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (dialogContext) => const AddPupilDialog(),
    );

    // If the user cancelled or dismissed the dialog, do nothing
    if (result == null) return;

    try {
      await ConnectorConnector.instance
          .createUserProfile(
        name: result['name']!,
        email: result['email']!,
      )
          .execute();

      if (!mounted) return;

      setState(_loadPupils);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pupil added successfully')),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not add pupil: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('pupils'),),
      body: FutureBuilder(
        future: _pupilsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Could not load pupils:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No data received.'));
          }

          final pupils = snapshot.data!.data.users;

          if (pupils.isEmpty) {
            return const Center(child: Text('No pupils found yet.'));
          }

          return ListView.builder(
            itemCount: pupils.length,
            itemBuilder: (context, index) {
              final pupil = pupils[index];

              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PupilScreen(id: pupil.id,),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person_outline),
                    ),
                    title: Text(pupil.name),
                    subtitle: Text(pupil.email),
                    trailing: Text(pupil.role),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addPupil,
        icon: const Icon(Icons.person_add),
        label: const Text('Add pupil'),
      ),
    );
  }
}

/// A self-contained dialog widget that safely manages its own controllers,
/// focus state, and form key to prevent framework assertion errors.
class AddPupilDialog extends StatefulWidget {
  const AddPupilDialog({super.key});

  @override
  State<AddPupilDialog> createState() => _AddPupilDialogState();
}

class _AddPupilDialogState extends State<AddPupilDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add pupil'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full name',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email address',
              ),
              validator: (value) {
                if (value == null || !value.contains('@')) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Dismiss keyboard safely before popping
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context); // Pops with null (indicating cancellation)
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              FocusManager.instance.primaryFocus?.unfocus();
              // Pop with the entered data map
              Navigator.pop(context, {
                'name': _nameController.text.trim(),
                'email': _emailController.text.trim(),
              });
            }
          },
          child: const Text('Save pupil'),
        ),
      ],
    );
  }
}