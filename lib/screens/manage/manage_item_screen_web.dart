// lib/screens/manage_item_screen.dart

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:visionary/models/vision_item.dart';
import 'package:visionary/services/firebase_service.dart';
import 'package:visionary/widgets/add_item_form.dart';
import 'package:visionary/widgets/vision_app_bar_web.dart';

class ManageItemScreenWeb extends StatefulWidget {
  final VisionItem? visionItem; // Optional vision item for editing

  const ManageItemScreenWeb({super.key, this.visionItem});

  @override
  State<ManageItemScreenWeb> createState() => _ManageItemScreenState();
}

class _ManageItemScreenState extends State<ManageItemScreenWeb>
    with TickerProviderStateMixin {
  final FirebaseService _firebaseService = FirebaseService();

  // Function to handle form submission
  Future<void> _handleFormSubmit(String itemText, String imageUrl) async {
    if (widget.visionItem == null) {
      // Adding a new vision item
      await _firebaseService.addVisionItem(itemText, imageUrl);
    } else {
      // Editing an existing vision item
      await _firebaseService.updateVisionItem(
          widget.visionItem!.id, itemText, imageUrl);
    }

    Navigator.pop(context); // Navigate back after submission
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: VisionAppBarWeb(
          title: widget.visionItem == null ? 'Add Item' : 'Edit Item',
        ),
        body: AnimatedBackground(
          vsync: this,
          behaviour: BubblesBehaviour(),
          child: Center(
            child: Container(
              width: 500,
              child: Card(
                margin: const EdgeInsets.all(16),
                child: AddItemForm(
                  initialItemText: widget.visionItem?.itemText ?? '',
                  initialImageUrl: widget.visionItem?.imageUrl ?? '',
                  onSubmit: _handleFormSubmit, // Pass the submit handler
                ),
              ),
            ),
          ),
        ));
  }
}
