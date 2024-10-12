// lib/presenters/board_presenter.dart

import 'package:visionary/models/vision_item.dart';
import 'package:visionary/services/firebase_service.dart';

class BoardPresenter {
  final FirebaseService _firebaseService;
  late Function(List<VisionItem>) onVisionItemsFetched;
  late Function(String) onError;

  BoardPresenter(this._firebaseService);

  void fetchVisionItems() {
    _firebaseService.getVisionItems().listen((items) {
      onVisionItemsFetched(items);
    }).onError((error) {
      onError(error.toString());
    });
  }

  Future<void> deleteVisionItem(String id) async {
    try {
      await _firebaseService.deleteVisionItem(id);
      fetchVisionItems(); // Refresh the list
    } catch (e) {
      onError(e.toString());
    }
  }
}
