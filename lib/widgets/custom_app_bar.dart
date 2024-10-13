// lib/widgets/custom_app_bar.dart

import 'package:flutter/material.dart';
import 'package:visionary/services/firebase_service.dart';
import 'package:visionary/utils/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    this.title = Constants.appTitle,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(Constants.appBarHeightWeb);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 42,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: .4),
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            icon: const Icon(Icons.logout),
            tooltip: Constants.logoutTip,
            onPressed: () async {
              await _firebaseService.signOut();
              Navigator.pushReplacementNamed(context, Constants.loginScreen);
            },
          ),
        ),
        const SizedBox(width: 20),
      ],
      shadowColor: Colors.brown,
      centerTitle: true,
      toolbarHeight: 100,
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
        child: Image.asset(
          'images/header.jpg',
          fit: BoxFit.cover,
          repeat: ImageRepeat.repeatX,
        ),
      ),
    );
  }
}
