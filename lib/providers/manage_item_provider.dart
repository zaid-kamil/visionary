// lib/providers/manage_item_provider.dart

import 'package:flutter/material.dart';
import 'package:visionary/models/vision_item.dart';
import 'package:visionary/services/firebase_service.dart';

class ManageItemProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  // This method is called when the user taps the "Save" button
  Future<void> handleFormSubmit(
      String itemText, String imageUrl, VisionItem? visionItem) async {
    try {
      if (visionItem == null) {
        await _firebaseService.addVisionItem(itemText, imageUrl);
      } else {
        await _firebaseService.updateVisionItem(
            visionItem.id, itemText, imageUrl);
      }
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
