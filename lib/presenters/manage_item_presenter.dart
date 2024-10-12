// lib/presenters/manage_item_presenter.dart

import 'package:visionary/models/vision_item.dart';
import 'package:visionary/services/firebase_service.dart';

class ManageItemPresenter {
  final FirebaseService _firebaseService = FirebaseService();

  Future<void> handleFormSubmit(
      String itemText, String imageUrl, VisionItem? visionItem) async {
    if (visionItem == null) {
      await _firebaseService.addVisionItem(itemText, imageUrl);
    } else {
      await _firebaseService.updateVisionItem(
          visionItem.id, itemText, imageUrl);
    }
  }
}
