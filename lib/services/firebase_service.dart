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
      await _auth.signInWithPopup(googleProvider);
      return "Signed in with Google";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      return "An unknown error occurred";
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // Handle sign out error
      print("Error signing out: $e");
    }
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Add a new vision item to Firestore
  Future<void> addVisionItem(String itemText, String imageUrl) async {
    try {
      await _firestore.collection(Constants.visionItemsCollection).add({
        Constants.itemTextField: itemText,
        Constants.imageUrlField: imageUrl,
        Constants.timestampField: FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Handle add item error
      print("Error adding vision item: $e");
    }
  }

  // Update an existing vision item in Firestore
  Future<void> updateVisionItem(
      String documentId, String itemText, String imageUrl) async {
    try {
      await _firestore
          .collection(Constants.visionItemsCollection)
          .doc(documentId)
          .update({
        Constants.itemTextField: itemText,
        Constants.imageUrlField: imageUrl,
      });
    } catch (e) {
      // Handle update item error
      print("Error updating vision item: $e");
    }
  }

  // Delete a vision item from Firestore
  Future<void> deleteVisionItem(String documentId) async {
    try {
      await _firestore
          .collection(Constants.visionItemsCollection)
          .doc(documentId)
          .delete();
    } catch (e) {
      // Handle delete item error
      print("Error deleting vision item: $e");
    }
  }

  // Fetch all vision items for the current user
  Stream<List<VisionItem>> getVisionItems() {
    return _firestore
        .collection(Constants.visionItemsCollection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return VisionItem(
          id: doc.id,
          itemText: doc[Constants.itemTextField],
          imageUrl: doc[Constants.imageUrlField],
          timestamp: doc[Constants.timestampField].toDate(),
        );
      }).toList();
    });
  }
}
