import 'package:api/domain/models/product_model.dart';
import 'package:api/ui/pages/categoria/categoria.dart';
import 'package:api/ui/pages/categoria/categoria_provider.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColumnaDos extends StatelessWidget {
  const ColumnaDos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriaProvider = context.read<CategoriaProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: (() {
                categoriaProvider.setProductos();
                final categoria = CategoryModel(
                    id: 154, name: "Bombas Hidráulicas", slug: "bombas");
                final categorias = <CategoryModel>[categoria];
                categoriaProvider.setChildCategory(categorias);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const Categoria()));
              }),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: amarilloFrisa,
                child: Image.asset(
                  'assets/images/bomba-negra.png',
                  height: 30,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Bombas",
              style: TextStyle(
                  fontSize: 14,
                  color: negroFrisa,
                  fontFamily: 'NeoMedium',
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: (() {
                categoriaProvider.setProductos();
                final categoria = CategoryModel(
                    id: 157, name: "Láminas para Juntas", slug: "juntas");
                final categorias = <CategoryModel>[categoria];
                categoriaProvider.setChildCategory(categorias);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const Categoria()));
              }),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: amarilloFrisa,
                child: Image.asset(
                  'assets/images/lamina-negra.png',
                  height: 30,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Laminas",
              style: TextStyle(
                  fontSize: 14,
                  color: negroFrisa,
                  fontFamily: 'NeoMedium',
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: (() {
                         categoriaProvider.setProductos();
                final categoria = CategoryModel(
                    id: 158, name: "PTFE", slug: "ptfe");
                final categorias = <CategoryModel>[categoria];
                categoriaProvider.setChildCategory(categorias);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const Categoria()));
              }),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: amarilloFrisa,
                child: Image.asset(
                  'assets/images/tubo-negro.png',
                  height: 30,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "PTFE",
              style: TextStyle(
                  fontSize: 14,
                  color: negroFrisa,
                  fontFamily: 'NeoMedium',
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }
}
