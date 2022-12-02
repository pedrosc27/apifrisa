import 'package:api/domain/models/product_model.dart';
import 'package:api/ui/global_widgets/product_card.dart';

import 'package:flutter/material.dart';

class ProductosVertical extends StatelessWidget {
  final List<Producto> productos;
  const ProductosVertical({Key? key, required this.productos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: productos.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 256,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: ((context, index) {
        final producto = productos[index];

        return ProductoCard(
          producto: producto,
        );
      }),
    );
  }
}
