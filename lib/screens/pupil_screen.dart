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
        title: const Text('Details'),
      ),
      body: Center(
        child: ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.person_outline),
          ),
          title: Text(pupil.name),
          subtitle: Text(pupil.email),
          trailing: Text(pupil.role),
        )
      ),
    );
  }
}