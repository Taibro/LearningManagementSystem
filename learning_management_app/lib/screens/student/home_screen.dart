import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'widgets/shared/mesh_background.dart';
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
      backgroundColor: const Color(0xFFF8FAFC), // Nền sáng Slate cực sang
      body: MeshBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const HomeHeader(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CurrentClassCard().animate().fade(duration: 600.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
                      const SizedBox(height: 28),
                      const FunctionSection(),
                    ],
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
