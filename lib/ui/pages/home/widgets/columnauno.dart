import 'package:api/domain/models/product_model.dart';
import 'package:api/ui/pages/categoria/categoria.dart';
import 'package:api/ui/pages/categoria/categoria_provider.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColumnaUno extends StatelessWidget {
  const ColumnaUno({
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
                    id: 159,
                    name: "Sellos Mecánicos",
                    slug: "sellos-mecanicos");
                final categoria1 = CategoryModel(
                    id: 21,
                    name: "Sellos Mecánicos de Volumen",
                    slug: "sellos-mecanicos-de-volumen");
                final categoria2 = CategoryModel(
                    id: 22,
                    name: "Sellos Mecánicos de Semi-Proceso",
                    slug: "sellos-mecanicos-de-semi-proceso");
                final categoria3 = CategoryModel(
                    id: 23,
                    name: "Sellos Mecánicos de Proceso",
                    slug: "sellos-mecanicos-de-proceso");
                final categorias = <CategoryModel>[
                  categoria,
                  categoria1,
                  categoria2,
                  categoria3
                ];
                categoriaProvider.setChildCategory(categorias);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const Categoria()));
              }),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: amarilloFrisa,
                child: Image.asset(
                  'assets/images/resorte-negro.png',
                  height: 30,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Sellos Mec.",
              style: TextStyle(
                  fontSize: 13,
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const Categoria()));
              }),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: amarilloFrisa,
                child: Image.asset(
                  'assets/images/oring-negro.png',
                  height: 30,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "O'rings",
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
                    id: 156,
                    name: "Empaquetaduras Trenzadas",
                    slug: "empaquetaduras-trenzadas");
                final categorias = <CategoryModel>[categoria];
                categoriaProvider.setChildCategory(categorias);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const Categoria()));
              }),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: amarilloFrisa,
                child: Image.asset(
                  'assets/images/empaquetadura-negra.png',
                  height: 30,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Empaques",
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
