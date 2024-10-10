// lib/screens/vision_board_screen.dart

import 'package:flutter/material.dart';

import '../../models/vision_item.dart';
import '../responsive_widget.dart';
import 'manage_item_screen_web.dart';

class ManageItemScreen extends StatelessWidget {
  final VisionItem? visionItem;

  const ManageItemScreen({super.key, this.visionItem});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLayout: const Placeholder(),
      tabletLayout: const Placeholder(),
      webLayout: ManageItemScreenWeb(visionItem: visionItem),
    );
  }
}
