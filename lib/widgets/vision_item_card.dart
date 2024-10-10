// lib/widgets/vision_item_card.dart

import 'package:flutter/material.dart';
import 'package:visionary/models/vision_item.dart';

class VisionItemCard extends StatelessWidget {
  final VisionItem visionItem;
  final VoidCallback onEdit; // Callback for edit action
  final VoidCallback onDelete; // Callback for delete action

  const VisionItemCard({
    super.key,
    required this.visionItem,
    required this.onEdit,
    required this.onDelete,
  });

  // Function to format date
  String formatDate(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/default.jpg",
                image: visionItem.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display item text
                // Display date if available
                if (visionItem.timestamp != null)
                  Text(
                    "Added on: ${formatDate(visionItem.timestamp!)}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                const SizedBox(height: 6),
                Text(
                  visionItem.itemText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Edit and Delete buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: onEdit,
                      child: const Text('Edit'),
                    ),
                    OutlinedButton(
                      onPressed: onDelete,
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
