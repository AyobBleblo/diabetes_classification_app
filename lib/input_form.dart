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
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: $e")));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Prediction'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 2.5, // Adjust for height of text fields
                  children: [
                    _buildTextField("HighBP (0/1)", _highBPController),
                    _buildTextField("HighChol (0/1)", _highCholController),
                    _buildTextField("CholCheck (0/1)", _cholCheckController),
                    _buildTextField("BMI", _bmiController),
                    _buildTextField("Smoker (0/1)", _smokerController),
                    _buildTextField("Stroke (0/1)", _strokeController),
                    _buildTextField(
                      "HeartDiseaseorAttack (0/1)",
                      _heartDiseaseorAttackController,
                    ),
                    _buildTextField(
                      "PhysActivity (0/1)",
                      _physActivityController,
                    ),
                    _buildTextField("Fruits (0/1)", _fruitsController),
                    _buildTextField("Veggies (0/1)", _veggiesController),
                    _buildTextField(
                      "HvyAlcoholConsump (0/1)",
                      _hvyAlcoholConsumpController,
                    ),
                    _buildTextField(
                      "AnyHealthcare (0/1)",
                      _anyHealthcareController,
                    ),
                    _buildTextField(
                      "NoDocbcCost (0/1)",
                      _noDocbcCostController,
                    ),
                    _buildTextField("GenHlth (1-5)", _genHlthController),
                    _buildTextField("MentHlth (0-30)", _mentHlthController),
                    _buildTextField("PhysHlth (0-30)", _physHlthController),
                    _buildTextField("DiffWalk (0/1)", _diffWalkController),
                    _buildTextField("Sex (0/1)", _sexController),
                    _buildTextField("Age (1-13)", _ageController),
                    _buildTextField("Education (1-6)", _educationController),
                    _buildTextField("Income (1-8)", _incomeController),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Predict', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        if (double.tryParse(value) == null) {
          return 'Invalid';
        }
        return null;
      },
    );
  }
}
