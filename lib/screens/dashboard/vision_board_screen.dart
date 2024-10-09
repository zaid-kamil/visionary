import 'package:flutter/material.dart';
import 'package:visionary/screens/dashboard/vision_board_screen_web.dart';

import '../responsive_widget.dart';

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
