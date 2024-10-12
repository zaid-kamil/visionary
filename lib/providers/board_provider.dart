// lib/providers/board_provider.dart

import 'package:flutter/material.dart';
import 'package:visionary/models/vision_item.dart';
import 'package:visionary/services/firebase_service.dart';

class BoardProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<VisionItem> _visionItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<VisionItem> get visionItems => _visionItems;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  BoardProvider() {
    fetchVisionItems();
  }

  void fetchVisionItems() {
    _isLoading = true;
    notifyListeners();

    _firebaseService.getVisionItems().listen((items) {
      _visionItems = items;
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    }).onError((error) {
      _errorMessage = error.toString();
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> deleteVisionItem(String id) async {
    try {
      await _firebaseService.deleteVisionItem(id);
      fetchVisionItems();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
