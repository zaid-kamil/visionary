// lib/models/vision_item.dart

class VisionItem {
  final String id; // Unique identifier for Firestore document
  final String itemText; // The text of the vision item
  final String imageUrl; // The URL of the image associated with the vision item
  final DateTime?
      timestamp; // Optional: Timestamp for when the item was created

  VisionItem({
    required this.id,
    required this.itemText,
    required this.imageUrl,
    this.timestamp,
  });

  // Factory method to create a VisionItem from Firestore document snapshot
  factory VisionItem.fromMap(Map<String, dynamic> data, String documentId) {
    return VisionItem(
      id: documentId,
      itemText: data['itemText'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      timestamp: data['timestamp']?.toDate(), // Convert to DateTime if exists
    );
  }

  // Method to convert VisionItem to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'itemText': itemText,
      'imageUrl': imageUrl,
      'timestamp': timestamp ?? DateTime.now(), // Default to now if null
    };
  }
}
