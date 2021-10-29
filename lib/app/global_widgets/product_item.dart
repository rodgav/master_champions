import 'package:flutter/material.dart';
import 'package:master_champions/app/data/models/products_model.dart';
import 'package:master_champions/app/global_widgets/loading.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.0)),
        child: Image.network(
          product.imageUrl,
          loadingBuilder: (context, child, loadingProgress) =>
              loadingProgress == null ? child : const Loading(),
          errorBuilder: (_, __, ___) => Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
              child: const Center(
                child: Icon(Icons.error),
              )),
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
