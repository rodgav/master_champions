import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_champions/app/data/models/categorys_model.dart';
import 'package:master_champions/app/data/models/products_model.dart';
import 'package:master_champions/app/data/repositorys/db_repository.dart';
import 'package:master_champions/app/global_widgets/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductsLogic extends GetxController {
  final _dbRepository = Get.find<DbRepository>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  CategorysModel? _categorysModel;
  Category? _category;
  Category? _categoryNew;
  ProductsModel? _productsModel;
  Uint8List? _bytes;
  String _nameFile = '';

  CategorysModel? get categorysModel => _categorysModel;

  Category? get category => _category;

  Category? get categoryNew => _categoryNew;

  ProductsModel? get productsModel => _productsModel;

  @override
  void onReady() {
    _getCategorys();
    super.onReady();
  }

  @override
  void dispose() {
    _nameCtrl.clear();
    super.dispose();
  }

  void _getCategorys() async {
    _categorysModel = await _dbRepository.getCategorys();
    if (categorysModel != null) {
      _category = categorysModel!.categorys[0];
      update(['categorys']);
      _getProducts(category!.id);
    }
  }

  void _getProducts(int idCategory) async {
    _productsModel = await _dbRepository.getProducts(idCategory: idCategory);
    update(['products']);
  }

  void selectCategory(Category categor) {
    _category = categor;
    update(['categorys']);
    _getProducts(categor.id);
  }

  void launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  String? isNotEmpty(String? text) {
    if (text != null) if (text.isNotEmpty) return null;
    return 'Ingrese datos';
  }

  void newCategory() {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 400,
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      const Center(
                        child: Text(
                          'Nueva Categoria',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        bottom: 0,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                              child: const Icon(Icons.close, color: Colors.red),
                              onTap: toBack),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nombre',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  TextFormField(
                    controller: _nameCtrl,
                    validator: (value) => isNotEmpty(value),
                    decoration: InputDecoration(
                        hintText: 'Nombre',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                        onPressed: createCategoria,
                        child: const Text('Guardar')),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void newProduct() {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 400,
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    const Center(
                      child: Text(
                        'Nuevo producto',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                            child: const Icon(Icons.close, color: Colors.red),
                            onTap: toBack),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Categoria',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                GetBuilder<ProductsLogic>(
                    id: 'categoryNew',
                    builder: (_) {
                      final categorysModel = _.categorysModel;
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: categorysModel != null
                            ? _categorysModel!.categorys.isNotEmpty
                                ? DropdownButton<Category>(
                                    isExpanded: true,
                                    value: _categoryNew,
                                    hint: const Text('Categoria'),
                                    underline: const SizedBox(),
                                    items: _categorysModel!.categorys
                                        .map((e) => DropdownMenuItem<Category>(
                                            value: e, child: Text(e.name)))
                                        .toList(),
                                    onChanged: (value) =>
                                        categorySelect(value as Category),
                                  )
                                : const Center(
                                    child: Text('No hay categorias'),
                                  )
                            : const Loading(),
                      );
                    }),
                const SizedBox(height: 10),
                const Text(
                  'Seleccione una iamgen',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                GetBuilder<ProductsLogic>(
                    id: 'picked',
                    builder: (_) {
                      final name = _._nameFile;
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _filePicker,
                          child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black)),
                              height: 50,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(name))),
                        ),
                      );
                    }),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                      onPressed: createNewProduct,
                      child: const Text('Guardar')),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void toBack() {
    Get.rootDelegate.popRoute();
  }

  void _filePicker() async {
    final pdfPicked = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg'],
        withData: true);
    if (pdfPicked != null) {
      _bytes = pdfPicked.files.single.bytes!;
      //_base64PDF = base64Encode(bytes);
      _nameFile = pdfPicked.files.single.name;
      update(['picked']);
    }
  }

  void _dialogLoading() {
    Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 10,
              ),
            ),
          ),
        ),
        barrierDismissible: false);
  }

  void createNewProduct() async {
    if (categoryNew != null) {
      if (_bytes != null) {
        _dialogLoading();
        final response = await _dbRepository.createProduct(
            idCategory: categoryNew!.id, image: base64Encode(_bytes!));
        Get.back();
        if (response != null) {
          _categoryNew = null;
          _bytes = null;
          _getProducts(category!.id);
          Get.back();
        } else {
          _snackBar(Colors.red, 'ERROR', 'Error al crear un producto');
        }
      } else {
        _snackBar(Colors.red, 'ERROR', 'Seleccione una imagen');
      }
    } else {
      _snackBar(Colors.red, 'ERROR', 'Seleccione una categoria');
    }
  }

  void _snackBar(Color color, String title, String body) {
    Get.snackbar(
      title,
      body,
      colorText: color,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.easeOutBack,
      margin: const EdgeInsets.all(15),
    );
  }

  void categorySelect(Category category) {
    _categoryNew = category;
    update(['categoryNew']);
  }

  void createCategoria() async {
    if (_formKey.currentState!.validate()) {
      _dialogLoading();
      final response =
          await _dbRepository.createCategory(name: _nameCtrl.text.trim());
      Get.back();
      if (response != null) {
        _nameCtrl.clear();
        _getCategorys();
        Get.back();
      } else {
        _snackBar(Colors.red, 'ERROR', 'Error al crear una nueva categoria');
      }
    }
  }
}
