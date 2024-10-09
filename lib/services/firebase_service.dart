// lib/services/firebase_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visionary/models/vision_item.dart';

import '../utils/constants.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in with Google
  Future<String> signInWithGoogle() async {
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      await FirebaseAuth.instance.signInWithPopup(googleProvider);
      return "Signed in with Google";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Add a new vision item to Firestore
  Future<void> addVisionItem(String itemText, String imageUrl) async {
    await _firestore.collection(Constants.visionItemsCollection).add({
      Constants.itemTextField: itemText,
      Constants.imageUrlField: imageUrl,
      Constants.timestampField: FieldValue.serverTimestamp(),
    });
  }

  // Update an existing vision item in Firestore
  Future<void> updateVisionItem(
      String documentId, String itemText, String imageUrl) async {
    await _firestore
        .collection(Constants.visionItemsCollection)
        .doc(documentId)
        .update({
      Constants.itemTextField: itemText,
      Constants.imageUrlField: imageUrl,
    });
  }

  // Delete a vision item from Firestore
  Future<void> deleteVisionItem(String documentId) async {
    await _firestore
        .collection(Constants.visionItemsCollection)
        .doc(documentId)
        .delete();
  }

  // Fetch all vision items for the current user
  Stream<List<VisionItem>> getVisionItems() {
    return FirebaseFirestore.instance
        .collection(Constants.visionItemsCollection)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => VisionItem(
                  id: doc.id,
                  itemText: doc[Constants.itemTextField],
                  imageUrl: doc[Constants.imageUrlField],
                  timestamp: doc[Constants.timestampField].toDate(),
                ))
            .toList());
  }
}
