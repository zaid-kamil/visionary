// lib/screens/vision_board_screen.dart

import 'package:flutter/material.dart';

import '../responsive_widget.dart';
import 'manage_item_screen_web.dart';

class ManageItemScreen extends StatelessWidget {
  const ManageItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileLayout: Placeholder(),
      tabletLayout: Placeholder(),
      webLayout: ManageItemScreenWeb(), // Web layout
    );
  }
}
