// lib/screens/dashboard/board_screen.dart
import 'package:flutter/material.dart';
import 'package:visionary/screens/dashboard/board_screen_web.dart';
import 'package:visionary/screens/responsive_widget.dart';

class VisionBoardScreen extends StatelessWidget {
  const VisionBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileLayout: Placeholder(),
      tabletLayout: Placeholder(),
      webLayout: VisionBoardScreenWeb(),
    );
  }
}
