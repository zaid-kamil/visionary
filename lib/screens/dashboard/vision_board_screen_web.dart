// lib/screens/vision_board_screen_web.dart

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:visionary/models/vision_item.dart';
import 'package:visionary/screens/manage/manage_item_screen.dart';
import 'package:visionary/services/firebase_service.dart';
import 'package:visionary/widgets/vision_app_bar_web.dart';
import 'package:visionary/widgets/vision_item_card.dart';

class VisionBoardScreenWeb extends StatefulWidget {
  const VisionBoardScreenWeb({super.key});

  @override
  State<VisionBoardScreenWeb> createState() => _VisionBoardScreenWebState();
}

class _VisionBoardScreenWebState extends State<VisionBoardScreenWeb>
    with TickerProviderStateMixin {
  final FirebaseService _firebaseService = FirebaseService();
  List<VisionItem> visionItems = [];

  // Function to fetch vision items
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
    // Fetch vision items when the screen is loaded
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
      appBar: const VisionAppBarWeb(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // goto add screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ManageItemScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: AnimatedBackground(
        vsync: this,
        behaviour: BubblesBehaviour(),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: GridView.builder(
                itemCount: visionItems.length,
                itemBuilder: (context, index) {
                  final visionItem = visionItems[index];
                  return VisionItemCard(
                    visionItem: visionItem,
                    onEdit: () {
                      // goto edit screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManageItemScreen(
                            visionItem: visionItem,
                          ),
                        ),
                      );
                    },
                    onDelete: () => _deleteVisionItem(visionItem.id),
                  );
                },
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
