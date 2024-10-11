// lib/models/vision_item.dart

class VisionItem {
  final String id; // Unique identifier for Firestore document
  final String itemText; // The text of the vision item
  final String imageUrl; // The URL of the image associated with the vision item
  final DateTime timestamp;

  VisionItem({
    required this.id,
    required this.itemText,
    required this.imageUrl,
    required this.timestamp,
  });
}
