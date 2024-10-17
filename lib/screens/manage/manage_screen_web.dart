// screens/manage/manage_screen.dart

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visionary/models/vision_item.dart';
import 'package:visionary/providers/manage_item_provider.dart';
import 'package:visionary/widgets/add_item_form.dart';
import 'package:visionary/widgets/custom_app_bar.dart';

class ManageScreenWeb extends StatefulWidget {
  final VisionItem? visionItem;
  const ManageScreenWeb({super.key, this.visionItem});

  @override
  State<ManageScreenWeb> createState() => _ManageScreenWebState();
}

class _ManageScreenWebState extends State<ManageScreenWeb>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider is used to provide the ManageItemProvider to the widget tree
    return ChangeNotifierProvider(
      create: (_) => ManageItemProvider(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.visionItem == null ? 'Add Item' : 'Edit Item',
        ),
        body: AnimatedBackground(
            vsync: this,
            behaviour: BubblesBehaviour(),
            child: Center(
              child: SizedBox(
                  width: 500,
                  child: Card(
                    margin: const EdgeInsets.all(16),
                    child: Consumer<ManageItemProvider>(
                        builder: (context, provider, child) {
                      return AddItemForm(
                          initialItemText: widget.visionItem?.itemText ?? '',
                          initialImageUrl: widget.visionItem?.imageUrl ?? '',
                          onSubmit: (itemText, imageUrl) async {
                            await provider.handleFormSubmit(
                                itemText, imageUrl, widget.visionItem);
                            if (provider.errorMessage == null) {
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(provider.errorMessage!)),
                              );
                            }
                          });
                    }),
                  )),
            )),
      ),
    );
  }
}
