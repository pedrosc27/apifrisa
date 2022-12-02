import 'package:api/domain/models/product_model.dart';
import 'package:api/ui/global_widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductosHorizontal extends StatefulWidget {
  final List<Producto> productos;
  const ProductosHorizontal({Key? key, required this.productos})
      : super(key: key);

  @override
  State<ProductosHorizontal> createState() => _ProductosHorizontalState();
}

class _ProductosHorizontalState extends State<ProductosHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.productos.length,
        separatorBuilder: ((context, index) => const SizedBox(
              width: 11,
            )),
        itemBuilder: ((context, index) {
          final producto = widget.productos[index];

          return ProductoCard(
            producto: producto,
          );
        }),
      ),
    );
  }
}
