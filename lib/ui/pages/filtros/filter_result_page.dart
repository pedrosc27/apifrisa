import 'package:api/ui/global_widgets/productos_vertical.dart';
import 'package:api/ui/global_widgets/shimer_vertical.dart';
import 'package:api/ui/pages/filtros/filtros_provider.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiltrosResultados extends StatefulWidget {
  const FiltrosResultados({Key? key}) : super(key: key);

  @override
  State<FiltrosResultados> createState() => _FiltrosResultadosState();
}

class _FiltrosResultadosState extends State<FiltrosResultados> {
  @override
  void initState() {
    final filtrosProvider = context.read<FiltrosProvider>();
    filtrosProvider.getProductsByCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filtrosProvider = context.watch<FiltrosProvider>();
    final productos = filtrosProvider.productos;
    final cargado = filtrosProvider.cargado;

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
        title: const Text(
          "Productos",
          style: TextStyle(
              fontSize: 18,
              color: negroFrisa,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: cargado == false
                        ? const ShimerVertical()
                        : Container(
                            child: productos.isEmpty
                                ? Center(
                                    heightFactor: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Column(children: [
                                        Image.asset(
                                          "assets/images/magnifier.png",
                                          width: 90,
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        const Text(
                                          "Sello no encontrado",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: negroFrisa,
                                              fontFamily: 'NeoMedium',
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          "Comunicate con nosotros, podemos apoyarte con el sello que estas buscando",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: negroFrisa,
                                              fontFamily: 'NeoRegular',
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        GestureDetector(
                                          onTap: (() {}),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Container(
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              decoration: const BoxDecoration(
                                                color: negroFrisa,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Enviar mensaje',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'NeoMedium',
                                                      color: amarilloFrisa,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  )
                                : ProductosVertical(productos: productos))),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
