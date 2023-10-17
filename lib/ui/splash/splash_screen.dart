import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/size/screen_size.dart';
import '../app/app.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _init() async {
    await Future.delayed(const Duration(seconds: 3));

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const App();
          },
        ),
      );
    }
  }

  @override
  void initState() {
  _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     width = MediaQuery.of(context).size.width;
     height = MediaQuery.of(context).size.height;
    return  Scaffold(
      body: Center(child: Lottie.asset('assets/lottie/background.json'),),
    );
  }
}
