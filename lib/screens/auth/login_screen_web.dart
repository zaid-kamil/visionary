// lib/screens/auth/login_screen_web.dart

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:visionary/providers/login_provider.dart';
import 'package:visionary/utils/constants.dart';

class LoginScreenWeb extends StatefulWidget {
  const LoginScreenWeb({super.key});

  @override
  State<LoginScreenWeb> createState() => _LoginScreenWebState();
}

class _LoginScreenWebState extends State<LoginScreenWeb>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // addPostFrameCallback is used to execute the callback after the frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // checkLoginStatus is called to check if the user is already logged in
      Provider.of<LoginProvider>(context, listen: false).checkLoginStatus();
      // if the user is already logged in, navigate to the VisionBoardScreen
      if (Provider.of<LoginProvider>(context, listen: false).isLoggedIn) {
        Navigator.pushReplacementNamed(context, Constants.visionBoardScreen);
      }
    });
  }

  void handleSignIn() async {
    // signIn is called when the user taps the "Sign in with Google" button
    await Provider.of<LoginProvider>(context, listen: false).signIn();
    if (Provider.of<LoginProvider>(context, listen: false).isLoggedIn) {
      Navigator.pushReplacementNamed(context, Constants.visionBoardScreen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              Provider.of<LoginProvider>(context, listen: false).errorMessage ??
                  'An error occurred'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider is used to provide the LoginProvider to the widget tree
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Scaffold(
        body: AnimatedBackground(
          vsync: this,
          behaviour: BubblesBehaviour(),
          child: Center(
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'animations/login.json',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'DartByte Dashboard',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: handleSignIn,
                    icon: const FaIcon(FontAwesomeIcons.google),
                    label: const Text(
                      Constants.googleSignInButtonText,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      iconColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
