import 'package:flutter/cupertino.dart';
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
    return GetRouterOutlet.builder(builder: (context, delegate, current) {
      debugPrint('title ${current?.location}');
      return Scaffold(
          body: Column(
        children: [
          Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            /*decoration:const BoxDecoration(  color: Colors.white,boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(0, 1), blurRadius: 7)
                ]),*/
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              runAlignment: WrapAlignment.spaceAround,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                      //width: size.width*0.5,
                      fit: BoxFit.cover,
                    ),
                    onTap: logic.goHome,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(child: GetRouterOutlet(initialRoute: Routes.home))
        ],
      ));
    });
  }
}
