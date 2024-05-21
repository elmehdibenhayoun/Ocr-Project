import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocr/Controllers/tab_index_controller.dart';
import 'package:ocr/views/face_detector.dart';
import 'package:ocr/views/mainPage.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = const [
    FaceDetectorPage(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabIndexController());
    return Obx(() => Scaffold(
          body: Stack(
            children: [
              pageList[controller.tabIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(canvasColor: Colors.blueAccent),
                  child: BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    unselectedIconTheme:
                        const IconThemeData(color: Colors.black38),
                    selectedIconTheme:
                        const IconThemeData(color: Colors.amberAccent),
                    onTap: (value) {
                      controller.setTabIndex = value;
                    },
                    currentIndex: controller.tabIndex,
                    items: [
                      BottomNavigationBarItem(
                          icon: controller.tabIndex == 0
                              ? const Icon(FontAwesome.user_circle)
                              : const Icon(FontAwesome.user_circle_o),
                          label: 'Face'),
                      BottomNavigationBarItem(
                          icon: controller.tabIndex == 1
                              ? const Icon(FontAwesome.file_code_o)
                              : const Icon(FontAwesome.file_text_o),
                          label: 'Profile'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
