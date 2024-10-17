// lib/screens/dashboard/board_screen_web.dart

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visionary/providers/board_provider.dart';
import 'package:visionary/screens/manage/manage_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text(Constants.addVisionItem),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ManageScreen()));
          },
          backgroundColor: Colors.orangeAccent,
          icon: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Consumer<BoardProvider>(builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          } else if (provider.visionItems.isEmpty) {
            return const Center(child: Text(Constants.emptyBoardMessage));
          } else {
            return AnimatedBackground(
                vsync: this,
                behaviour: BubblesBehaviour(),
                child: GridView.builder(
                  itemCount: provider.visionItems.length,
                  itemBuilder: (context, index) {
                    final visionItem = provider.visionItems[index];
                    return VisionItemCard(
                      visionItem: visionItem,
                      onEdit: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ManageScreen(visionItem: visionItem)));
                      },
                      onDelete: () => provider.deleteVisionItem(visionItem.id),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 500),
                ));
          }
        }));
  }
}
