// lib/screens/manage/manage_screen.dart

import 'package:flutter/material.dart';
import 'package:visionary/models/vision_item.dart';
import 'package:visionary/screens/manage/manage_screen_web.dart';
import 'package:visionary/screens/responsive_widget.dart';

class ManageScreen extends StatelessWidget {
  final VisionItem? visionItem;

  const ManageScreen({super.key, this.visionItem});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLayout: const Placeholder(),
      tabletLayout: const Placeholder(),
      webLayout: ManageScreenWeb(visionItem: visionItem),
    );
  }
}
