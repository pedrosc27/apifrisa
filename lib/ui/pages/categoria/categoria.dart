import 'package:api/domain/models/product_model.dart';
import 'package:api/ui/global_widgets/error_vertical.dart';
import 'package:api/ui/global_widgets/productos_vertical.dart';
import 'package:api/ui/global_widgets/shimer_vertical.dart';
import 'package:api/ui/pages/categoria/categoria_provider.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categoria extends StatefulWidget {
  const Categoria({Key? key}) : super(key: key);

  @override
  State<Categoria> createState() => _CategoriaState();
}

class _CategoriaState extends State<Categoria> {
  String nombre = "";
  List<CategoryModel> categorias = [];
  int selector = 0;
  @override
  void initState() {
    final categoriaProvider = context.read<CategoriaProvider>();
    nombre = categoriaProvider.childCategoryIds.first.name ?? "";
    categorias = categoriaProvider.childCategoryIds;
    categoriaProvider.getProductsByCategory(categorias[0].id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoriaProvider = context.watch<CategoriaProvider>();
    final productos = categoriaProvider.productos;
    final cargado = categoriaProvider.cargado;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: amarilloFrisa,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: negroFrisa,
          ),
        ),
        title: Text(
          nombre,
          style: const TextStyle(
              fontSize: 18,
              color: negroFrisa,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              categorias.length == 1
                  ? const SizedBox()
                  : Container(
                      width: double.infinity,
                      height: 48,
                      color: amarilloFrisa,
                      padding: const EdgeInsets.only(left: 16, bottom: 8),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: ((context, index) => const SizedBox(
                              width: 11,
                            )),
                        itemCount: categorias.length,
                        itemBuilder: ((context, index) {
                          final categoria = categorias[index];
                          return GestureDetector(
                            onTap: (() {
                              setState(() {
                                categoriaProvider.setProductos();
                                categoriaProvider
                                    .getProductsByCategory(categoria.id!);
                                selector = index;
                                nombre = categoria.name ?? "";
                              });
                            }),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: selector == index
                                        ? negroFrisa
                                        : amarilloFrisa,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  categoria.name ?? "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: selector == index
                                          ? amarilloFrisa
                                          : negroFrisa,
                                      fontFamily: 'NeoRegular',
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: cargado
                      ? Container(
                          child: productos.isEmpty
                              ? const ErrorVertical()
                              : ProductosVertical(productos: productos),
                        )
                      : const ShimerVertical()),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
