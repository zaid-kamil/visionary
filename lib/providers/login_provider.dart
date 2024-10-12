// lib/providers/login_provider.dart

import 'package:flutter/material.dart';
import 'package:visionary/services/firebase_service.dart';

class LoginProvider with ChangeNotifier {
  // private fields
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoggedIn = false;
  String? _errorMessage;

  // these are the getters for the private fields
  bool get isLoggedIn => _isLoggedIn;
  String? get errorMessage => _errorMessage;

  // This method is called when the user taps the "Sign in with Google" button
  Future<void> signIn() async {
    try {
      await _firebaseService.signInWithGoogle();
      _isLoggedIn = true;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  // This method is called when the user taps the "Sign out" button
  void signOut() async {
    await _firebaseService.signOut();
    _isLoggedIn = false;
    notifyListeners();
  }

  // This method is called when the app starts
  void checkLoginStatus() {
    _isLoggedIn = _firebaseService.getCurrentUser() != null;
    notifyListeners();
  }
}
