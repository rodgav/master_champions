import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:master_champions/app/data/services/auth_service.dart';
import 'package:master_champions/app/global_widgets/footer.dart';
import 'package:master_champions/app/global_widgets/product_item.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.find<HomeLogic>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool web = size.width > 800;
    return Scaffold(
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: size.width,
                    child: Wrap(
                      alignment: web
                          ? WrapAlignment.spaceBetween
                          : WrapAlignment.center,
                      runAlignment: web
                          ? WrapAlignment.spaceBetween
                          : WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 10,
                      spacing: 10,
                      children: [
                        const Text(
                          'Productos',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: logic.goProducts,
                            child: const Text(
                              'Ver mas',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              const SizedBox(height: 10),
              GetBuilder<HomeLogic>(
                  id: 'products',
                  builder: (_) {
                    final productsModel = _.productsModel;
                    return SizedBox(
                      height: 200,
                      child: productsModel != null
                          ? productsModel.products.isNotEmpty
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (__, index) {
                                    int totalLista =
                                        AuthService.to.userId != null
                                            ? productsModel.products.length + 1
                                            : productsModel.products.length;
                                    if (AuthService.to.userId != null &&
                                        index == 0) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            child: Container(
                                                width: 200,
                                                height: 200,
                                                padding: EdgeInsets.only(
                                                    left: 20,
                                                    right:
                                                        index == totalLista - 1
                                                            ? 20
                                                            : 0),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
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
                                        ),
                                      );
                                    } else {
                                      final product = AuthService.to.userId !=
                                              null
                                          ? productsModel.products[index - 1]
                                          : productsModel.products[index];
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: index == totalLista - 1
                                                ? 20
                                                : 0),
                                        child: ProductItem(product: product),
                                      );
                                    }
                                  },
                                  itemCount: AuthService.to.userId != null
                                      ? productsModel.products.length + 1
                                      : productsModel.products.length,
                                )
                              : const Center(
                                  child: Text('No hay datos'),
                                )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    );
                  }),
              const SizedBox(height: 30),
              Container(
                height: size.height * 0.5,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'SOBRE NOSOTROS',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Somos una empresa que busca ayudar cumplir los objetivos '
                      'nutricionales. Contamos con una selecta variedad de '
                      'productos que pertenecen a marcas top de calidad '
                      'internacional preparados para apoyarte en tu régimen de '
                      'objetivos.Te invitamos a comprobar los beneficios y '
                      'resultados al consumir nuestros productos. Aminoacidos, '
                      'Proteinas, y mucho mas.',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: size.width,
                padding: const EdgeInsets.all(20),
                child: Wrap(
                  alignment:
                      web ? WrapAlignment.spaceBetween : WrapAlignment.center,
                  runAlignment:
                      web ? WrapAlignment.spaceBetween : WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'UBÍCANOS',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: Image.asset(
                              'assets/images/ubicacion.png',
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'REDES SOCIALES',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: size.width * 0.4,
                            child: Wrap(
                              alignment: web
                                  ? WrapAlignment.spaceAround
                                  : WrapAlignment.center,
                              runAlignment: web
                                  ? WrapAlignment.spaceAround
                                  : WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runSpacing: 10,
                              spacing: 10,
                              children: [
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    child: Image.asset(
                                      'assets/images/facebook.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    onTap: () => logic
                                        .launchURL('https://www.facebook.com/'),
                                  ),
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    child: Image.asset(
                                      'assets/images/instagram.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    onTap: () => logic.launchURL(
                                        'https://www.instagram.com/?hl=es'),
                                  ),
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    child: Image.asset(
                                      'assets/images/whatsapp.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    onTap: () => logic
                                        .launchURL('https://web.whatsapp.com/'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Center(
                  child: FooterWid(
                      voidCallback: () =>
                          logic.launchURL('https://rsgmsolutions.com')))
            ],
          )),
    );
  }
}
