import 'package:api/ui/pages/buscar/buscar_provider.dart';
import 'package:api/ui/pages/producto/producto.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({Key? key}) : super(key: key);

  @override
  State<BuscarPage> createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(
        "https://api.whatsapp.com/send/?phone=5218183369539&text&app_absent=0");

    if (await canLaunchUrl(_url)) {
      await launchUrl(_url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final buscarProvider = context.watch<BuscarProvider>();
    final productos = buscarProvider.productos;
    final cargado = buscarProvider.cargado;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: amarilloFrisa,
        elevation: 0,
        title: const Text(
          "Filtros",
          style: TextStyle(
              fontSize: 18,
              color: negroFrisa,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: amarilloFrisa,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.search,
                              color: gris,
                              size: 25,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                hintText: "Buscar producto",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              onChanged: (value) async {
                                if (value.length >= 3) {
                                  final busqueda = await buscarProvider
                                      .buscarProducto(value);
                                }
                                if (productos.isNotEmpty && value.length < 3) {
                                  final busqueda =
                                      buscarProvider.resetProductos();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
              Container(
                child: cargado == false
                    ? const SizedBox()
                    : productos.isEmpty
                        ? Center(
                            heightFactor: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(children: [
                                Image.asset(
                                  "assets/images/magnifier.png",
                                  width: 90,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  "Producto no encontrado",
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
                                  "Comunicate con nosotros, podemos apoyarte con el producto que estas buscando",
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
                                  onTap: (() async {
                                    _launchUrl();
                                  }),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
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
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: productos.length,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final producto = productos[index];
                              return GestureDetector(
                                onTap: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ProductoPage(
                                            producto: producto,
                                          )));
                                }),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: grisFrisa),
                                        child: Image.network(
                                          producto.images![0].src!,
                                          width: 40,
                                        ),
                                      ),
                                      // ignore: prefer_const_constructors
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          producto.name!,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: negroFrisa,
                                              fontFamily: 'NeoRegular',
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
