import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.find<HomeLogic>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool web = size.width > 800;
    const tileHeight = 200.0;
    const tileWidth = 200.0;
    const spacing = 10.0;
    return Column(
      children: [
        Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => Container(
              width: 140,
              height: 70,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text('Categoria $index'),
              ),
            ),
            itemCount: 50,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: LayoutBuilder(builder: (context, constaints) {
              final count = constaints.maxWidth ~/ tileWidth;
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: count,
                    childAspectRatio: tileHeight / tileWidth,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing),
                itemBuilder: (_, index) => Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text('Producto $index'),
                  ),
                ),
                itemCount: 50,
              );
            }),
          ),
        ),
      ],
    );
  }
}
