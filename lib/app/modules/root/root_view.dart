import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_champions/app/routes/app_pages.dart';

import 'root_logic.dart';

class RootPage extends StatelessWidget {
  final logic = Get.find<RootLogic>();

  RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool web = size.width > 800;
    return GetRouterOutlet.builder(builder: (context, delegate, current) {
      debugPrint('title ${current?.location}');
      return Scaffold(
          body: Column(
            children: [
              Container(
                height: 70,
                width: size.width,
                padding:const EdgeInsets.symmetric(horizontal: 20),
                decoration:const BoxDecoration(  color: Colors.white,boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(0, 1), blurRadius: 7)
                ]),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () => null,
                        icon: const Icon(
                          Icons.person,
                          color: Colors.blueAccent,
                          size: 30,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(child: GetRouterOutlet(initialRoute: Routes.home)),
            ],
          ));
    });
  }
}
