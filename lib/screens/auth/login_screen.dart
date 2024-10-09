import 'package:flutter/material.dart';
import 'package:visionary/screens/auth/login_screen_web.dart';

import '../responsive_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileLayout: Placeholder(),
      tabletLayout: Placeholder(),
      webLayout: LoginScreenWeb(),
    );
  }
}
