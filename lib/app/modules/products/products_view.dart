import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_champions/app/data/services/auth_service.dart';
import 'package:master_champions/app/global_widgets/footer.dart';
import 'package:master_champions/app/global_widgets/product_item.dart';

import 'products_logic.dart';

class ProductsPage extends StatelessWidget {
  final logic = Get.find<ProductsLogic>();

  ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const tileHeight = 200.0;
    const tileWidth = 200.0;
    const spacing = 10.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Categorias',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
        const SizedBox(height: 5),
        GetBuilder<ProductsLogic>(
            id: 'categorys',
            builder: (_) {
              final categorysModel = _.categorysModel;
              final category = _.category;
              return SizedBox(
                height: 40,
                child: categorysModel != null
                    ? categorysModel.categorys.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (__, index) {
                              if (AuthService.to.userId != null && index == 0) {
                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: Colors.blue)),
                                      margin: const EdgeInsets.only(left: 20),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(
                                                Icons.add,
                                                color: Colors.blue,
                                              ),
                                              SizedBox(width: 5),
                                              Text('Nueva categoria',
                                                  style: TextStyle(
                                                      color: Colors.blue)),
                                            ],
                                          )),
                                    ),
                                    onTap: _.newCategory,
                                  ),
                                );
                              } else {
                                final categor = AuthService.to.userId != null
                                    ? categorysModel.categorys[index - 1]
                                    : categorysModel.categorys[index];
                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: category == categor
                                              ? Colors.blue
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: Colors.blue)),
                                      margin: const EdgeInsets.only(left: 20),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(categor.name,
                                              style: TextStyle(
                                                  color: category == categor
                                                      ? Colors.white
                                                      : Colors.blue))),
                                    ),
                                    onTap: () => _.selectCategory(categor),
                                  ),
                                );
                              }
                            },
                            itemCount: AuthService.to.userId != null
                                ? categorysModel.categorys.length + 1
                                : categorysModel.categorys.length)
                        : const Center(child: Text('Tareas no encontradas'))
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              );
            }),
        Expanded(
          child: GetBuilder<ProductsLogic>(
              id: 'products',
              builder: (_) {
                final productsModel = _.productsModel;
                return productsModel != null
                    ? productsModel.products.isNotEmpty
                        ? Container(
                            margin: const EdgeInsets.only(
                                top: 20, right: 20, left: 20),
                            child:
                                LayoutBuilder(builder: (context, constaints) {
                              final count = constaints.maxWidth ~/ tileWidth;
                              return GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: count,
                                        childAspectRatio:
                                            tileHeight / tileWidth,
                                        crossAxisSpacing: spacing,
                                        mainAxisSpacing: spacing),
                                itemBuilder: (__, index) {
                                  if (AuthService.to.userId != null &&
                                      index == 0) {
                                    return MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        child: Container(
                                            width: 200,
                                            height: 200,
                                            decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            child: Center(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  Icon(Icons.add,
                                                      color: Colors.blue,
                                                      size: 50),
                                                  SizedBox(height: 5),
                                                  Text('Nuevo producto')
                                                ],
                                              ),
                                            )),
                                        onTap: _.newProduct,
                                      ),
                                    );
                                  } else {
                                    final product =
                                        AuthService.to.userId != null
                                            ? productsModel.products[index - 1]
                                            : productsModel.products[index];
                                    return ProductItem(product: product);
                                  }
                                },
                                itemCount: AuthService.to.userId != null
                                    ? productsModel.products.length + 1
                                    : productsModel.products.length,
                              );
                            }),
                          )
                        : const Center(
                            child: Text('No hay datos'),
                          )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              }),
        ),
        Center(
            child: FooterWid(
                voidCallback: () =>
                    logic.launchURL('https://rsgmsolutions.com')))
      ],
    );
  }
}
