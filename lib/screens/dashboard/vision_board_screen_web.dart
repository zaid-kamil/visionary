// lib/screens/vision_board_screen_web.dart

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:visionary/models/vision_item.dart';
import 'package:visionary/screens/manage/manage_item_screen.dart';
import 'package:visionary/services/firebase_service.dart';
import 'package:visionary/widgets/vision_app_bar_web.dart';
import 'package:visionary/widgets/vision_item_card.dart';

import '../../utils/constants.dart';

class VisionBoardScreenWeb extends StatefulWidget {
  const VisionBoardScreenWeb({super.key});

  @override
  State<VisionBoardScreenWeb> createState() => _VisionBoardScreenWebState();
}

class _VisionBoardScreenWebState extends State<VisionBoardScreenWeb>
    with TickerProviderStateMixin {
  final FirebaseService _firebaseService = FirebaseService();
  List<VisionItem> visionItems = [];
  bool isLoading = true;

  // Function to fetch vision items
  Future<void> _fetchVisionItems() async {
    _firebaseService.getVisionItems().listen((items) {
      if (mounted) {
        setState(() {
          visionItems = items;
          isLoading = false;
        });
      }
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
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(Constants.addVisionItem),
        onPressed: () {
          // goto add screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ManageItemScreen(),
            ),
          );
        },
        backgroundColor: Colors.orangeAccent,
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: AnimatedBackground(
        vsync: this,
        behaviour: BubblesBehaviour(),
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: const Center(
            child: CircularProgressIndicator(),
          ),
          secondChild: Row(
            children: [
              visionItems.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Text(Constants.emptyBoardMessage),
                      ),
                    )
                  : Expanded(
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
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 500,
                        ),
                      ),
                    ),
            ],
          ),
          crossFadeState:
              isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ),
    );
  }
}
