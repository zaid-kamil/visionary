// lib/presenters/login_presenter.dart

import 'package:visionary/services/firebase_service.dart';

class LoginPresenter {
  final FirebaseService _firebaseService;

  LoginPresenter(this._firebaseService);

  Future<String> handleSignIn() async {
    final result = await _firebaseService.signInWithGoogle();
    return result;
  }

  bool isUserLoggedIn() {
    return _firebaseService.getCurrentUser() != null;
  }
}
