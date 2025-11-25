import 'dart:io';
import 'package:flutter/material.dart';
import 'diabetes_model.dart';
import 'api_service.dart';
import 'result_page.dart';

class DiabetesPredictionPage extends StatefulWidget {
  const DiabetesPredictionPage({super.key});

  @override
  State<DiabetesPredictionPage> createState() => _DiabetesPredictionPageState();
}

class _DiabetesPredictionPageState extends State<DiabetesPredictionPage> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  // Controllers for all fields
  final TextEditingController _highBPController = TextEditingController(
    text: "1",
  );
  final TextEditingController _highCholController = TextEditingController(
    text: "1",
  );
  final TextEditingController _cholCheckController = TextEditingController(
    text: "1",
  );
  final TextEditingController _bmiController = TextEditingController(
    text: "30",
  );
  final TextEditingController _smokerController = TextEditingController(
    text: "0",
  );
  final TextEditingController _strokeController = TextEditingController(
    text: "0",
  );
  final TextEditingController _heartDiseaseorAttackController =
      TextEditingController(text: "1");
  final TextEditingController _physActivityController = TextEditingController(
    text: "0",
  );
  final TextEditingController _fruitsController = TextEditingController(
    text: "1",
  );
  final TextEditingController _veggiesController = TextEditingController(
    text: "1",
  );
  final TextEditingController _hvyAlcoholConsumpController =
      TextEditingController(text: "0");
  final TextEditingController _anyHealthcareController = TextEditingController(
    text: "1",
  );
  final TextEditingController _noDocbcCostController = TextEditingController(
    text: "0",
  );
  final TextEditingController _genHlthController = TextEditingController(
    text: "5",
  );
  final TextEditingController _mentHlthController = TextEditingController(
    text: "30",
  );
  final TextEditingController _physHlthController = TextEditingController(
    text: "30",
  );
  final TextEditingController _diffWalkController = TextEditingController(
    text: "1",
  );
  final TextEditingController _sexController = TextEditingController(text: "0");
  final TextEditingController _ageController = TextEditingController(text: "9");
  final TextEditingController _educationController = TextEditingController(
    text: "5",
  );
  final TextEditingController _incomeController = TextEditingController(
    text: "1",
  );

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final input = DiabetesInput(
          highBP: double.parse(_highBPController.text),
          highChol: double.parse(_highCholController.text),
          cholCheck: double.parse(_cholCheckController.text),
          bmi: double.parse(_bmiController.text),
          smoker: double.parse(_smokerController.text),
          stroke: double.parse(_strokeController.text),
          heartDiseaseorAttack: double.parse(
            _heartDiseaseorAttackController.text,
          ),
          physActivity: double.parse(_physActivityController.text),
          fruits: double.parse(_fruitsController.text),
          veggies: double.parse(_veggiesController.text),
          hvyAlcoholConsump: double.parse(_hvyAlcoholConsumpController.text),
          anyHealthcare: double.parse(_anyHealthcareController.text),
          noDocbcCost: double.parse(_noDocbcCostController.text),
          genHlth: double.parse(_genHlthController.text),
          mentHlth: double.parse(_mentHlthController.text),
          physHlth: double.parse(_physHlthController.text),
          diffWalk: double.parse(_diffWalkController.text),
          sex: double.parse(_sexController.text),
          age: double.parse(_ageController.text),
          education: double.parse(_educationController.text),
          income: double.parse(_incomeController.text),
        );

        final result = await _apiService.predict(input);

        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResultPage(result: result)),
          );
        }
      } on SocketException {
        if (mounted) {
          _showErrorDialog(
            "لا يوجد اتصال بالإنترنت",
            "يرجى التحقق من إعدادات الإنترنت والمحاولة مرة أخرى.",
          );
        }
      } catch (e) {
        if (mounted) {
          _showErrorDialog(
            "حدث خطأ ما",
            "لم نتمكن من معالجة طلبك. يرجى المحاولة مرة أخرى لاحقاً.\n\nالتفاصيل: $e",
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title, style: const TextStyle(color: Colors.red)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("حسناً"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('توقع السكري'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 1.0, // Adjusted for extra text height
                    children: [
                      _buildTextField(
                        "ضغط الدم المرتفع (0/1)",
                        _highBPController,
                        Icons.favorite,
                      ),
                      _buildTextField(
                        "الكوليسترول المرتفع (0/1)",
                        _highCholController,
                        Icons.water_drop,
                      ),
                      _buildTextField(
                        "فحص الكوليسترول (0/1)",
                        _cholCheckController,
                        Icons.check_circle,
                      ),
                      _buildTextField(
                        "مؤشر كتلة الجسم (BMI)",
                        _bmiController,
                        Icons.monitor_weight,
                      ),
                      _buildTextField(
                        "مدخن (0/1)",
                        _smokerController,
                        Icons.smoking_rooms,
                      ),
                      _buildTextField(
                        "سكتة دماغية (0/1)",
                        _strokeController,
                        Icons.medical_services,
                      ),
                      _buildTextField(
                        "أمراض القلب (0/1)",
                        _heartDiseaseorAttackController,
                        Icons.heart_broken,
                      ),
                      _buildTextField(
                        "نشاط بدني (0/1)",
                        _physActivityController,
                        Icons.directions_run,
                      ),
                      _buildTextField(
                        "فواكه (0/1)",
                        _fruitsController,
                        Icons.apple,
                      ),
                      _buildTextField(
                        "خضروات (0/1)",
                        _veggiesController,
                        Icons.grass,
                      ),
                      _buildTextField(
                        "استهلاك الكحول (0/1)",
                        _hvyAlcoholConsumpController,
                        Icons.local_drink,
                      ),
                      _buildTextField(
                        "رعاية صحية (0/1)",
                        _anyHealthcareController,
                        Icons.local_hospital,
                      ),
                      _buildTextField(
                        "تكلفة الطبيب (0/1)",
                        _noDocbcCostController,
                        Icons.money_off,
                      ),
                      _buildTextField(
                        "الصحة العامة (1-5)",
                        _genHlthController,
                        Icons.health_and_safety,
                      ),
                      _buildTextField(
                        "الصحة النفسية (0-30)",
                        _mentHlthController,
                        Icons.psychology,
                      ),
                      _buildTextField(
                        "الصحة الجسدية (0-30)",
                        _physHlthController,
                        Icons.sick,
                      ),
                      _buildTextField(
                        "صعوبة المشي (0/1)",
                        _diffWalkController,
                        Icons.accessible,
                      ),
                      _buildTextField(
                        "الجنس (0/1)",
                        _sexController,
                        Icons.person,
                      ),
                      _buildTextField(
                        "العمر (1-13)",
                        _ageController,
                        Icons.calendar_today,
                      ),
                      _buildTextField(
                        "التعليم (1-6)",
                        _educationController,
                        Icons.school,
                      ),
                      _buildTextField(
                        "الدخل (1-8)",
                        _incomeController,
                        Icons.attach_money,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'توقع النتيجة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: controller,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '!';
                }
                if (double.tryParse(value) == null) {
                  return '!';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
