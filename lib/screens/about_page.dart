import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('About Us'),
      ),
      body: Markdown(
        data: '''
# Centosys      
      
We bring solutions to your smartphone making your daily life easier to access your locals
and around through our apps.

We understand your challenges and needs for your daily life.

.. requires content here ..
      ''',
      ),
    );
  }
}
