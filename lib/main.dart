import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ocr/views/entryPoint.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'OCR',
          home: const FlutterSplashScreen(),
        );
      },
    );
  }
}

class FlutterSplashScreen extends StatelessWidget {
  const FlutterSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreenGif(
      gifPath: 'assets/ezgif-7-79a74e8062.gif',
      gifWidth: 269.w, // Use ScreenUtil for adaptive sizing
      gifHeight: 474.h, // Use ScreenUtil for adaptive sizing
      nextScreen: MainScreen(),
      duration: const Duration(milliseconds: 4000),
      onInit: () async {
        debugPrint("onInit");
      },
      onEnd: () async {
        debugPrint("onEnd 1");
      },
    );
  }
}

class FlutterSplashScreenGif extends StatelessWidget {
  final String gifPath;
  final double gifWidth;
  final double gifHeight;
  final Widget nextScreen;
  final Duration duration;
  final Future<void> Function() onInit;
  final Future<void> Function() onEnd;

  const FlutterSplashScreenGif({
    required this.gifPath,
    required this.gifWidth,
    required this.gifHeight,
    required this.nextScreen,
    required this.duration,
    required this.onInit,
    required this.onEnd,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    onInit();

    Future.delayed(duration, () async {
      await onEnd();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => nextScreen),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          gifPath,
          width: gifWidth,
          height: gifHeight,
        ),
      ),
    );
  }
}
