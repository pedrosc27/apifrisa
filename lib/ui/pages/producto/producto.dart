import 'package:api/domain/models/cart_model.dart';
import 'package:api/ui/pages/carrito/carrito_provider.dart';
import 'package:flutter/material.dart';
import 'package:api/domain/models/product_model.dart';
import 'package:api/ui/global_widgets/productos_horizontal.dart';
import 'package:api/ui/pages/producto/producto_provider.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ProductoPage extends StatefulWidget {
  final Producto producto;
  const ProductoPage({Key? key, required this.producto}) : super(key: key);

  @override
  State<ProductoPage> createState() => ProductoPageState();
}

class ProductoPageState extends State<ProductoPage> {
  List<Attribute>? atributos;
  List<int>? numeros;
  int? cantidad;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    cantidad = 1;
    atributos = widget.producto.attributes
        ?.where((atributo) => atributo.variation == true)
        .toList();
    numeros = List<int>.filled(atributos!.length, 0, growable: true);

    final productosRelacionados = context
        .read<ProductoPageProvider>()
        .getProductsByIds(widget.producto.relatedIds!);

    super.initState();
  }

  void _onShare(BuildContext context, String link) async {
    final compartir = link.replaceAll("/api", "");
    print(compartir);
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(compartir,
        subject: 'link',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Se añadio al carrito'),
      backgroundColor: negroFrisa,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 2000),
      action: SnackBarAction(
        label: 'Cerrar',
        disabledTextColor: Colors.white,
        textColor: amarilloFrisa,
        onPressed: () {
          //Do whatever you want
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final producto = widget.producto;
    final productoProvider = 
        context.watch<ProductoPageProvider>();
    final productosRelacionados =productoProvider.products;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: grisFrisa,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: amarilloFrisa,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: negroFrisa,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _onShare(context, producto.permalink!);
                      },
                      child: Container(
                        child: const Icon(
                          Icons.share,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: grisFrisa,
                width: double.infinity,
                height: size.height * 0.40,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: producto.images![0].src!,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * .7,
                      child: Text(
                        producto.name!,
                        maxLines: 4,
                        style: const TextStyle(
                            fontSize: 24,
                            color: negroFrisa,
                            fontFamily: 'NeoMedium',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: amarilloFrisa,
                      child: Image.asset(
                        'assets/images/pdf-file.png',
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              atributos!.isEmpty
                  ? const SizedBox()
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        itemCount: atributos!.length,
                        itemBuilder: ((context, index) {
                          final atributo = atributos![index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text('${atributo.name}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'NeoMedium',
                                      color: negroFrisa,
                                      fontWeight: FontWeight.w400)),
                              const SizedBox(height: 20),
                              Wrap(
                                runSpacing: 10,
                                spacing: 10,
                                runAlignment: WrapAlignment.center,
                                children: List.generate(
                                    atributos![index].options!.length,
                                    (indexOpciones) {
                                  final opciones = atributos![index].options;
                                  final opcion = opciones![indexOpciones];
                                  return Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: ChoiceChip(
                                      label: Text(
                                        opcion,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 15,
                                      ),
                                      selected:
                                          numeros![index] == indexOpciones,
                                      selectedColor: negroFrisa,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          numeros![index] =
                                              selected ? indexOpciones : 0;
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: grisVazel, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: Colors.white,
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          color:
                                              numeros![index] == indexOpciones
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontFamily: 'NeoRegular',
                                          fontWeight: FontWeight.w400),
                                    ),
                                  );
                                }),
                              )
                            ],
                          );
                        }),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text('Cantidad : ',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'NeoMedium',
                        color: negroFrisa,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: (size.width * .5) - 32,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                cantidad = int.tryParse(value) ?? cantidad;
                              });
                            },
                            initialValue: '1',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(width: 1, color: grisVazel),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(width: 1, color: grisVazel),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (() async{
                        
                        showSnackBar(context);
                        String descripcion = "";

                        if (atributos?.length != 0) {
                          for (var i = 0; i < atributos!.length; i++) {
                            final atributo = atributos![i];
                            descripcion = descripcion +
                                atributo.name! +
                                ": " +
                                atributo.options![numeros![i]] +
                                ", ";
                          }
                        } else {
                          descripcion = "sin descripcion";
                        }
                      final productoCarrito = CartModel(nombre: producto.name, imagen: producto.images![0].src, descripcion: descripcion, cantidad: cantidad );
                      final carritoProvider = context.read<CarritoProvider>();
                      await carritoProvider.agregarProducto(productoCarrito);
                       
                      }),
                      child: Container(
                        width: (size.width * .5) - 16,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: const BoxDecoration(
                          color: negroFrisa,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Añadir al Carrito',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'NeoMedium',
                                color: amarilloFrisa,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text('Tambíen podría interesarte ...  ',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'NeoMedium',
                        color: negroFrisa,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(
                height: 20,
              ),
              productosRelacionados?.length == null
                  ? const SizedBox()
                  : ProductosHorizontal(
                      productos: productosRelacionados!,
                    )
            ],
          ),
        )),
      ),
    );
  }
}
