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
    String title;

    if (result == "Diabetes") {
      resultColor = Colors.redAccent;
      resultIcon = Icons.warning_rounded;
      title = "خطر مرتفع";
      message =
          "يتوقع النموذج خطراً مرتفعاً للإصابة بالسكري. يرجى استشارة طبيب فوراً.";
    } else if (result == "Pre-diabetes") {
      resultColor = Colors.orangeAccent;
      resultIcon = Icons.health_and_safety;
      title = "خطر متوسط";
      message =
          "يتوقع النموذج مرحلة ما قبل السكري. فكر في تغيير نمط حياتك واستشر طبيباً.";
    } else {
      resultColor = Colors.blue; // Blue for healthy in this theme
      resultIcon = Icons.check_circle_outline;
      title = "خطر منخفض";
      message = "يتوقع النموذج عدم وجود سكري. حافظ على نمط حياتك الصحي!";
    }

    return Scaffold(
      appBar: AppBar(title: const Text('نتيجة التوقع'), elevation: 0),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(resultIcon, size: 100, color: resultColor),
                        const SizedBox(height: 24),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: resultColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          result,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[800],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'العودة',
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
}
