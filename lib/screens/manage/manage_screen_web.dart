// lib/screens/manage/manage_item_screen_web.dart

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:visionary/models/vision_item.dart';
import 'package:visionary/presenters/manage_item_presenter.dart';
import 'package:visionary/widgets/add_item_form.dart';
import 'package:visionary/widgets/custom_app_bar.dart';

class ManageItemScreenWeb extends StatefulWidget {
  final VisionItem? visionItem;

  const ManageItemScreenWeb({super.key, this.visionItem});

  @override
  State<ManageItemScreenWeb> createState() => _ManageItemScreenState();
}

class _ManageItemScreenState extends State<ManageItemScreenWeb>
    with TickerProviderStateMixin {
  final ManageItemPresenter _presenter = ManageItemPresenter();

  Future<void> _handleFormSubmit(String itemText, String imageUrl) async {
    await _presenter.handleFormSubmit(itemText, imageUrl, widget.visionItem);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: AddItemForm(
                initialItemText: widget.visionItem?.itemText ?? '',
                initialImageUrl: widget.visionItem?.imageUrl ?? '',
                onSubmit: _handleFormSubmit,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
