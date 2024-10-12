// lib/screens/manage/manage_screen.dart

import 'package:flutter/material.dart';
import 'package:visionary/models/vision_item.dart';
import 'package:visionary/screens/responsive_widget.dart';

class ManageItemScreen extends StatelessWidget {
  final VisionItem? visionItem;

  const ManageItemScreen({super.key, this.visionItem});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileLayout: Placeholder(),
      tabletLayout: Placeholder(),
      webLayout: ManageItemScreen(),
    );
  }
}
