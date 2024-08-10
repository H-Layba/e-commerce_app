import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Chat Support'),
            onTap: () {
              Navigator.pushNamed(context, '/support/chat');
            },
          ),
          ListTile(
            title: Text('Feedback'),
            onTap: () {
              Navigator.pushNamed(context, '/support/feedback');
            },
          ),
        ],
      ),
    );
  }
}
