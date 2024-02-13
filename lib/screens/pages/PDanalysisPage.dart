import 'package:flutter/material.dart';

class PDanalysisPage extends StatefulWidget {
  const PDanalysisPage({super.key});

  @override
  State<PDanalysisPage> createState() => _PDanalysisPageState();
}

class _PDanalysisPageState extends State<PDanalysisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PD Analysis'),
      ),
      body: const Center(
        child: Text(
          'PD Analysis Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}