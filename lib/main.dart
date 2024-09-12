import 'package:flutter/material.dart';
import 'package:sample_to_do_app_ui/views/home_view.dart';

void main() {
  runApp(const SampleToDoAppUI());
}

class SampleToDoAppUI extends StatelessWidget {
  const SampleToDoAppUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
