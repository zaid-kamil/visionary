// lib/screens/vision_board_screen_web.dart

import 'package:flutter/material.dart';
import 'package:visionary/models/vision_item.dart';
import 'package:visionary/services/firebase_service.dart';
import 'package:visionary/widgets/add_item_form.dart';
import 'package:visionary/widgets/vision_item_card.dart';

class VisionBoardScreenWeb extends StatefulWidget {
  const VisionBoardScreenWeb({super.key});

  @override
  State<VisionBoardScreenWeb> createState() => _VisionBoardScreenWebState();
}

class _VisionBoardScreenWebState extends State<VisionBoardScreenWeb> {
  final FirebaseService _firebaseService = FirebaseService();
  List<VisionItem> visionItems = [];

  Future<void> _fetchVisionItems() async {
    _firebaseService.getVisionItems().listen((items) {
      setState(() {
        visionItems = items;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchVisionItems();
  }

  // Function to delete a vision item
  Future<void> _deleteVisionItem(String id) async {
    await _firebaseService.deleteVisionItem(id);
    _fetchVisionItems(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vision Board - Web'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: AddItemForm(
              onSubmit: (itemText, imageUrl) async {
                await _firebaseService.addVisionItem(itemText, imageUrl);
                _fetchVisionItems(); // Refresh the list
              },
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: visionItems.length,
              itemBuilder: (context, index) {
                final visionItem = visionItems[index];
                return VisionItemCard(
                  visionItem: visionItem,
                  onEdit: () {
                    // Handle edit action (navigate to edit screen)
                  },
                  onDelete: () => _deleteVisionItem(visionItem.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
