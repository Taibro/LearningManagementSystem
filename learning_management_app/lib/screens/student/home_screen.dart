import 'package:flutter/material.dart';
import 'widgets/home_header.dart';
import 'widgets/current_class_card.dart';
import 'widgets/function_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CurrentClassCard(),
                  const SizedBox(height: 20),
                  const FunctionSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
