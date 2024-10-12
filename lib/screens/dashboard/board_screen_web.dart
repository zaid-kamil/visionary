// lib/screens/board_screen_web.dart

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:visionary/models/vision_item.dart';
import 'package:visionary/presenters/board_presenter.dart';
import 'package:visionary/screens/manage/manage_screen.dart';
import 'package:visionary/services/firebase_service.dart';
import 'package:visionary/utils/constants.dart';
import 'package:visionary/widgets/custom_app_bar.dart';
import 'package:visionary/widgets/vision_item_card.dart';

class VisionBoardScreenWeb extends StatefulWidget {
  const VisionBoardScreenWeb({super.key});

  @override
  State<VisionBoardScreenWeb> createState() => _VisionBoardScreenWebState();
}

class _VisionBoardScreenWebState extends State<VisionBoardScreenWeb>
    with TickerProviderStateMixin {
  late BoardPresenter _presenter;
  List<VisionItem> visionItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _presenter = BoardPresenter(FirebaseService());
    _presenter.onVisionItemsFetched = (items) {
      setState(() {
        visionItems = items;
        isLoading = false;
      });
    };
    _presenter.onError = (error) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    };
    _presenter.fetchVisionItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(Constants.addVisionItem),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ManageItemScreen()));
        },
        backgroundColor: Colors.orangeAccent,
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: AnimatedBackground(
        vsync: this,
        behaviour: BubblesBehaviour(),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : visionItems.isEmpty
                ? const Center(child: Text(Constants.emptyBoardMessage))
                : GridView.builder(
                    itemCount: visionItems.length,
                    itemBuilder: (context, index) {
                      final visionItem = visionItems[index];
                      return VisionItemCard(
                        visionItem: visionItem,
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ManageItemScreen(visionItem: visionItem),
                            ),
                          );
                        },
                        onDelete: () =>
                            _presenter.deleteVisionItem(visionItem.id),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 500),
                  ),
      ),
    );
  }
}
