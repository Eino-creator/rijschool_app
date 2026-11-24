import 'package:material_ui/material_ui.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';

class CourseCostEditForm extends StatefulWidget {
  final dynamic costItem;
  final VoidCallback onSaved;

  const CourseCostEditForm({
    super.key,
    required this.costItem,
    required this.onSaved,
  });

  @override
  State<CourseCostEditForm> createState() =>
      _CourseCostEditFormState();
}

class _CourseCostEditFormState extends State<CourseCostEditForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _lessonTimeController;
  late final TextEditingController _lessonPriceController;
  late final TextEditingController _registrationFeeController;
  late final TextEditingController _selfDeclarationController;
  late final TextEditingController _brokerageFeesController;
  late final TextEditingController _examCarUsageController;

  bool _isSaving = false;

  String _initialValue(dynamic value, String fallback) {
    return value?.toString() ?? fallback;
  }

  @override
  void initState() {
    super.initState();

    final item = widget.costItem;

    _lessonTimeController = TextEditingController(
      text: _initialValue(item.lessonTime, '60'),
    );

    _lessonPriceController = TextEditingController(
      text: _initialValue(item.lessonPrice, '55.00'),
    );

    _registrationFeeController = TextEditingController(
      text: _initialValue(item.registrationFee, '35.00'),
    );

    _selfDeclarationController = TextEditingController(
      text: _initialValue(item.selfDeclaration, '41.50'),
    );

    _brokerageFeesController = TextEditingController(
      text: _initialValue(item.brokerageFees, '25.00'),
    );

    _examCarUsageController = TextEditingController(
      text: _initialValue(item.examCarUsage, '110.00'),
    );
  }

  @override
  void dispose() {
    _lessonTimeController.dispose();
    _lessonPriceController.dispose();
    _registrationFeeController.dispose();
    _selfDeclarationController.dispose();
    _brokerageFeesController.dispose();
    _examCarUsageController.dispose();

    super.dispose();
  }

  // Accept both 55.50 and 55,50 as decimal input.
  String _normaliseNumber(String value) {
    return value.trim().replaceAll(',', '.');
  }

  String? _validateMoney(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a price';
    }

    final amount = double.tryParse(_normaliseNumber(value));

    if (amount == null || !amount.isFinite) {
      return 'Please enter a valid number';
    }

    if (amount < 0) {
      return 'Price cannot be negative';
    }

    return null;
  }

  String? _validateLessonTime(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the lesson duration';
    }

    final minutes = int.tryParse(value.trim());

    if (minutes == null) {
      return 'Please enter a whole number';
    }

    if (minutes <= 0) {
      return 'Duration must be greater than zero';
    }

    return null;
  }


  Future<void> _save() async {
    if (_isSaving) return;

    FocusScope.of(context).unfocus();

    await Future<void>.delayed(
      const Duration(milliseconds: 100),
    );

    if (!mounted) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);

    try {
      final result = await ConnectorConnector.instance
          .editCourseCosts(
        id: widget.costItem.id.toString(),
        lessonTime: int.parse(
          _lessonTimeController.text.trim(),
        ),
        lessonPrice: double.parse(
          _normaliseNumber(_lessonPriceController.text),
        ),
        registrationFee: double.parse(
          _normaliseNumber(_registrationFeeController.text),
        ),
        selfDeclaration: double.parse(
          _normaliseNumber(_selfDeclarationController.text),
        ),
        brokerageFees: double.parse(
          _normaliseNumber(_brokerageFeesController.text),
        ),
        examCarUsage: double.parse(
          _normaliseNumber(_examCarUsageController.text),
        ),
      )
          .execute();

      if (result.data.courseCost_update == null) {
        throw Exception('The course cost was not updated.');
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Course costs updated successfully'),
        ),
      );

      widget.onSaved();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update course costs: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }


  Widget _buildMoneyField({
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
          signed: false,
        ),
        decoration: InputDecoration(
          labelText: label,
          prefixText: '€ ',
          border: const OutlineInputBorder(),
        ),
        validator: _validateMoney,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Edit Course Costs',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _lessonTimeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Lesson Duration (minutes)',
              suffixText: 'minutes',
              border: OutlineInputBorder(),
            ),
            validator: _validateLessonTime,
          ),

          const SizedBox(height: 12),

          _buildMoneyField(
            label: 'Lesson Price',
            controller: _lessonPriceController,
          ),

          _buildMoneyField(
            label: 'Registration Fee',
            controller: _registrationFeeController,
          ),

          _buildMoneyField(
            label: 'Self-Declaration',
            controller: _selfDeclarationController,
          ),

          _buildMoneyField(
            label: 'Brokerage Fees',
            controller: _brokerageFeesController,
          ),

          _buildMoneyField(
            label: 'Exam Car Usage',
            controller: _examCarUsageController,
          ),

          const SizedBox(height: 12),

          FilledButton(
            onPressed: _isSaving ? null : _save,
            child: _isSaving
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : const Text('Save Changes'),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
