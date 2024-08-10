import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();
  bool _isSubmitting = false;

  void _submitFeedback() async {
    if (_feedbackController.text.isNotEmpty) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate a network request or processing time
      await Future.delayed(Duration(seconds: 2));

      // Handle feedback submission (e.g., send to server)

      setState(() {
        _isSubmitting = false;
      });

      _feedbackController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feedback submitted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Feedback'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'We would love to hear your feedback!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _feedbackController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Enter your feedback here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.all(16),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(

              onPressed: _isSubmitting ? null : _submitFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isSubmitting
                  ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.white),
              )
                  : Text(
                'Submit Feedback',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
