import 'package:flutter/material.dart';
import 'package:tourist/utility/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width * .6,
          child: Image.asset(Images.logo),
        ),
      ),
    );
  }
}
