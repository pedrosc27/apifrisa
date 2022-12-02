import 'package:api/ui/global_widgets/productos_horizontal.dart';
import 'package:api/ui/global_widgets/shimer_horizontal.dart';
import 'package:api/ui/pages/home/home_provider.dart';
import 'package:api/ui/pages/home/widgets/cabecera.dart';
import 'package:api/ui/pages/home/widgets/home_cagetorias.dart';
import 'package:api/ui/pages/home/widgets/titulo_list_horizontal.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final homeProvider = context.read<HomeProvider>().getProductsByCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    final productos = context.watch<HomeProvider>().products;
    final sellos = productos
        ?.where((element) => element.categories!
            .where((element) => element.id == 159)
            .isNotEmpty)
        .toList();
    final bombas = productos
        ?.where((element) => element.categories!
            .where((element) => element.id == 154)
            .isNotEmpty)
        .toList();
    final juntas = productos
        ?.where((element) => element.categories!
            .where((element) => element.id == 157)
            .isNotEmpty)
        .toList();
    return Scaffold(
      body: Container(
        color: amarilloFrisa,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Cabecera(),
                  const SizedBox(
                    height: 20,
                  ),
                  const CategoriasHome(),
                  const TituloListHorizontal(
                      titulo: "Sellos Mecánicos Populares"),
                  sellos?.length == null
                      ? const ShimmerHorizontal()
                      : ProductosHorizontal(productos: sellos!),
                  const TituloListHorizontal(
                      titulo: "Bombas Hidráulicas Populares"),
                  bombas?.length == null
                      ? const ShimmerHorizontal()
                      : ProductosHorizontal(productos: bombas!),
                  const TituloListHorizontal(titulo: "Laminado para Juntas"),
                  juntas?.length == null
                      ? const ShimmerHorizontal()
                      : ProductosHorizontal(productos: juntas!),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
