// lib/utils/constants.dart

class Constants {
  // Firestore Collections
  static const String visionItemsCollection = 'vision_items';

  // Firebase Auth Provider ID
  static const String googleProviderId = 'google.com';

  // Routes (for navigation)
  static const String visionBoardScreen = '/visionBoard';
  static const String addEditItemScreen = '/addEditItem';
  static const String loginScreen = '/login';

  // UI Strings
  static const String appTitle = 'Visionary';
  static const String addVisionItem = 'Add New Vision';
  static const String editVisionItem = 'Edit Vision';
  static const String deleteVisionItem = 'Delete Vision';
  static const String emptyBoardMessage =
      'Your vision board is empty. Start adding your dreams!';

  // Firestore Fields
  static const String itemTextField = 'itemText';
  static const String imageUrlField = 'imageUrl';
  static const String timestampField = 'timestamp';

  // Miscellaneous
  static const String googleSignInButtonText = 'Sign in with Google';
  static const String logoutButtonText = 'Logout';
  static const String confirmDeleteMessage =
      'Are you sure you want to delete this vision item?';

  // Image Placeholders
  static const String placeholderImageUrl = 'https://via.placeholder.com/150';
}
