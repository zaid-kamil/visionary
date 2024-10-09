import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:visionary/screens/auth/login_screen.dart';

import 'firebase_options.dart';
import 'screens/dashboard/vision_board_screen.dart';
import 'screens/manage/manage_item_screen.dart';
import 'utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const VisionaryApp());
}

class VisionaryApp extends StatelessWidget {
  const VisionaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Constants.loginScreen,
      routes: {
        Constants.loginScreen: (context) => const LoginScreen(),
        Constants.visionBoardScreen: (context) => const VisionBoardScreen(),
        Constants.addEditItemScreen: (context) => const ManageItemScreen(),
      },
    );
  }
}
