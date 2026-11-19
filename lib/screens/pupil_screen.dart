import 'package:flutter/material.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';

class PupilScreen extends StatefulWidget {
  final String id;

  const PupilScreen({
    super.key,
    required this.id,
  });

  @override
  State<PupilScreen> createState() => _PupilScreenState();
}


class _PupilScreenState extends State<PupilScreen> {
  late Future<dynamic> _pupilFuture;

  @override
  void initState() {
    super.initState();
    _loadPupil();
  }

  void _loadPupil() {
    _pupilFuture = ConnectorConnector.instance.getPupil(userId: widget.id).execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pupil details'),
      ),
      body: FutureBuilder(
        future: _pupilFuture,
        builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Could not load pupil:\n${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No data received.'));
            }

            final pupil = snapshot.data!.data.users.first;

            return ListTile(
              leading: Text(pupil.role),
              title: Text(pupil.name),
              subtitle: Text(pupil.email),
              trailing: const CircleAvatar(
          child: Icon(Icons.person_outline),
          ),
            );
        },
      ),
    );
  }
}