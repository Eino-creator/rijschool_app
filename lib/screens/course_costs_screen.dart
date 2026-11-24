import 'package:material_ui/material_ui.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rijschool_app/widgets/course_cost_edit_form.dart';

class CourseCostsScreen extends StatefulWidget {
  const CourseCostsScreen({super.key});

  @override
  State<CourseCostsScreen> createState() =>
      _CourseCostsScreenState();
}

class _CourseCostsScreenState extends State<CourseCostsScreen> {
  late Future<dynamic> _courseCostsFuture;

  bool _isInstructorOrAdmin = false;
  bool _isLoadingRole = true;

  @override
  void initState() {
    super.initState();

    _loadCourseCosts();
    _checkRole();
  }

  void _loadCourseCosts() {
    _courseCostsFuture =
        ConnectorConnector.instance.getCourseCosts().execute();
  }

  void _refreshCourseCosts() {
    setState(() {
      _loadCourseCosts();
    });
  }

  Future<void> _checkRole() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        if (mounted) {
          setState(() => _isLoadingRole = false);
        }
        return;
      }

      final result = await ConnectorConnector.instance
          .getMyRole(firebaseUid: user.uid)
          .execute();

      final users = result.data.users;

      if (!mounted) return;

      setState(() {
        if (users.isNotEmpty) {
          final role = users.first.role.toUpperCase();

          _isInstructorOrAdmin =
              role == 'INSTRUCTOR' || role == 'ADMIN';
        }

        _isLoadingRole = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isInstructorOrAdmin = false;
        _isLoadingRole = false;
      });
    }
  }

  Future<void> _openSelectedCostForEditing() async {
    try {
      final result = await _courseCostsFuture;

      if (!mounted) return;

      final courseCosts = result.data.courseCosts;

      if (courseCosts.isEmpty) return;

      _openEditModal(courseCosts.first);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open course costs: $e'),
        ),
      );
    }
  }

  void _openEditModal(dynamic costItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: CourseCostEditForm(
              costItem: costItem,
              onSaved: () {
                Navigator.of(sheetContext).pop();
                _refreshCourseCosts();
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Costs & Pricing'),
      ),

      body: FutureBuilder<dynamic>(
        future: _courseCostsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Could not load course costs:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('No data received.'),
            );
          }

          final courseCosts = snapshot.data!.data.courseCosts;

          if (courseCosts.isEmpty) {
            return const Center(
              child: Text('No course costs found.'),
            );
          }

          // For now, use the first available CourseCost.
          // Later we can add selection of multiple records.
          final costItem = courseCosts.first;

          final totalExamCost =
              (costItem.examCarUsage as num).toDouble() +
                  (costItem.registrationFee as num).toDouble() +
                  (costItem.brokerageFees as num).toDouble();

          final items = [
            {
              'title': 'Instructor',
              'value': costItem.instructor.name,
              'isCurrency': false,
            },
            {
              'title': 'Lesson Duration',
              'value': '${costItem.lessonTime} minutes',
              'isCurrency': false,
            },
            {
              'title': 'Lesson Price',
              'value': costItem.lessonPrice,
              'isCurrency': true,
            },
            {
              'title': 'Registration Fee',
              'value': costItem.registrationFee,
              'isCurrency': true,
            },
            {
              'title': 'Self-Declaration',
              'value': costItem.selfDeclaration,
              'isCurrency': true,
            },
            {
              'title': 'Brokerage Fees',
              'value': costItem.brokerageFees,
              'isCurrency': true,
            },
            {
              'title': 'Exam Car Usage',
              'value': costItem.examCarUsage,
              'isCurrency': true,
            },
            {
              'title': 'Total Practical Exam Cat.B',
              'value': totalExamCost,
              'isCurrency': true,
            },
          ];

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Official Driving School Rates & Packages',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'All prices are in Euros (€) and include applicable fees.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                );
              }

              final item = items[index - 1];

              final isCurrency =
              item['isCurrency'] as bool;

              final dynamic value = item['value'];

              final valueStr = isCurrency
                  ? '€${(value as num).toStringAsFixed(2)}'
                  : value.toString();

              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item['title'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Text(
                        valueStr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isCurrency
                              ? Colors.green.shade700
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      bottomNavigationBar:
      !_isLoadingRole && _isInstructorOrAdmin
          ? Padding(
        padding: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: _openSelectedCostForEditing,
          icon: const Icon(Icons.edit),
          label: const Text('Edit Course Costs'),
        ),
      )
          : null,
    );
  }
}
