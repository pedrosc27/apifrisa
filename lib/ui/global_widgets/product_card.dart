import 'package:api/domain/models/product_model.dart';
import 'package:api/ui/pages/producto/producto.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductoCard extends StatelessWidget {
  final Producto producto;
  const ProductoCard({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
       Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductoPage(producto: producto,)));
      }),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
            color: grisVazel, borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: producto.images![0].src!,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(
              height: 8,
            ),
             Text(
              producto.name!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              maxLines: 1,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'NeoRegular',
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
