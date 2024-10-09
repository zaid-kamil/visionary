// lib/screens/manage_item_screen.dart

import 'package:flutter/material.dart';
import 'package:visionary/models/vision_item.dart';
import 'package:visionary/services/firebase_service.dart';
import 'package:visionary/widgets/add_item_form.dart';

class ManageItemScreenWeb extends StatefulWidget {
  final VisionItem? visionItem; // Optional vision item for editing

  const ManageItemScreenWeb({super.key, this.visionItem});

  @override
  State<ManageItemScreenWeb> createState() => _ManageItemScreenState();
}

class _ManageItemScreenState extends State<ManageItemScreenWeb> {
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
      appBar: AppBar(
        title: Text(
            widget.visionItem == null ? 'Add Vision Item' : 'Edit Vision Item'),
      ),
      body: AddItemForm(
        initialItemText: widget.visionItem?.itemText ?? '',
        initialImageUrl: widget.visionItem?.imageUrl ?? '',
        onSubmit: _handleFormSubmit, // Pass the submit handler
      ),
    );
  }
}
