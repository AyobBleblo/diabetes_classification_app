import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String result;

  const ResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    // Determine color and icon based on result
    Color resultColor;
    IconData resultIcon;
    String message;

    if (result == "Diabetes") {
      resultColor = Colors.red;
      resultIcon = Icons.warning_amber_rounded;
      message = "Please consult a healthcare professional.";
    } else if (result == "Pre-diabetes") {
      resultColor = Colors.orange;
      resultIcon = Icons.health_and_safety;
      message = "Consider lifestyle changes.";
    } else {
      resultColor = Colors.green;
      resultIcon = Icons.check_circle_outline;
      message = "Keep up the healthy lifestyle!";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction Result'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(resultIcon, size: 100, color: resultColor),
              const SizedBox(height: 24),
              Text(
                result,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: resultColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Back to Form',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
