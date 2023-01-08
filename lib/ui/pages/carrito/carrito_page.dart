import 'dart:io';

import 'package:api/domain/models/cart_model.dart';
import 'package:api/ui/global_widgets/shimer_vertical.dart';
import 'package:api/ui/pages/carrito/carrito_provider.dart';
import 'package:api/ui/pages/carrito/widgets/carrito_vacio.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:path_provider/path_provider.dart' as path;

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({Key? key}) : super(key: key);

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String nombre = "";
  String telefono = "";
  String email = "";
  String descripcion = "";
  List<CartModel> productosExcel = [];
  final myNotifier = ValueNotifier<bool>(false);

  void _onPressed() {
    myNotifier.value = true;
  }

  @override
  void initState() {
    super.initState();
    final carrito = context.read<CarritoProvider>().cargarCarrito();
  }

  @override
  Widget build(BuildContext context) {
    final carrito = context.watch<CarritoProvider>();
    final productosCarrito = carrito.listaCarrito;
    productosExcel = carrito.listaCarrito;
    final cargado = carrito.cargado;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: amarilloFrisa,
        elevation: 0,
        title: const Text(
          "Carrito",
          style: TextStyle(
              fontSize: 18,
              color: negroFrisa,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: negroFrisa,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        icon: const Icon(
          Icons.shopping_cart,
          color: amarilloFrisa,
        ),
        onPressed: () {
          print("aplicar filtros");
          
          _modalCorreo(context);
        },
        label: const Text(
          'Cotizar Productos',
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'NeoMedium',
              color: amarilloFrisa,
              fontWeight: FontWeight.w400),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Container(
              child: cargado == false
                  ? const ShimerVertical()
                  : Container(
                      child: productosCarrito.isEmpty
                          ? const CarritoVacio()
                          : Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: productosCarrito.length,
                                  physics: const ScrollPhysics(),
                                  itemBuilder: ((context, index) {
                                    final producto = productosCarrito[index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: grisFrisa,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            width: 100,
                                            height: 100,
                                            child: Image.network(
                                              producto.imagen!,
                                              width: 70,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    producto.nombre!,
                                                    maxLines: 5,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'NeoMedium',
                                                        color: negroFrisa,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  producto.descripcion! ==
                                                          "sin descripcion"
                                                      ? Text(
                                                          "Cantidad: ${producto.cantidad!}",
                                                          maxLines: 5,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'NeoRegular',
                                                              color: negroFrisa,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      : Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              producto
                                                                  .descripcion!,
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'NeoRegular',
                                                                  color:
                                                                      negroFrisa,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              "Cantidad: ${producto.cantidad!}",
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'NeoRegular',
                                                                  color:
                                                                      negroFrisa,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              print(producto.id);
                                              carrito
                                                  .borrarProducto(producto.id!);
                                            },
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 16),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                                const SizedBox(
                                  height: 60,
                                )
                              ],
                            ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  _modalCorreo(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        builder: (BuildContext bc) {
          return StatefulBuilder(// this is new
              builder: (BuildContext context, StateSetter setState) {
            return ListView(
              children: [
                Container(
                  color: Color(0xFF737373),

                  //could change this to Color(0xFF737373),
                  //so you don't have to change MaterialApp canvasColor
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0XFFEFF1F3),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0))),
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const Text('NOMBRE: ',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'NeoMedium',
                                color: negroFrisa,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _crearNombreProyecto(),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text('CORREO: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NeoMedium',
                                      color: negroFrisa,
                                      fontWeight: FontWeight.w400)),
                              const SizedBox(
                                height: 10,
                              ),
                              _crearCorreo(),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text('TELEFONO: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NeoMedium',
                                      color: negroFrisa,
                                      fontWeight: FontWeight.w400)),
                              const SizedBox(
                                height: 10,
                              ),
                              _crearTelefono(),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text('COMENTARIO: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NeoMedium',
                                      color: negroFrisa,
                                      fontWeight: FontWeight.w400)),
                              const SizedBox(
                                height: 10,
                              ),
                              _crearComentario(),
                              const SizedBox(
                                height: 25,
                              ),
                              Center(
                                  child: Container(
                                width: 300, // <-- match_parent
                                child: ValueListenableBuilder<bool>(
                                    valueListenable: myNotifier,
                                    builder: (context, value, child) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(15),
                                          backgroundColor: negroFrisa,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: Text(
                                          value
                                              ? "Cotización solicitada"
                                              : "Enviar",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'NeoMedium',
                                              color: amarilloFrisa,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        onPressed: () {
                                        
                                          _submit();
                                        },
                                      );
                                    }),
                              )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }

  void _submit() async {
   

    formKey.currentState!.save();
    createExcel();
    Navigator.pop(context);
    final carrito = context.read<CarritoProvider>();
    await carrito.borrarTodosLosProductos();
    showSnackBar(context);
    // refreshNotes();
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Se solicitó la cotización'),
      backgroundColor: negroFrisa,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 2500),
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


  Future<void> createExcel() async {
    final excel.Workbook workbook = excel.Workbook();
    final excel.Worksheet sheet = workbook.worksheets[0];

    int autoContador = 0;
    int coladoContador = 0;
    int concretoContador = 0;

    sheet.getRangeByName('A1').setText('Nombre');
    sheet.getRangeByName('A2').setText('Telefono');
    sheet.getRangeByName('A3').setText('Email');
    sheet.getRangeByName('A4').setText('Comentarios');

    sheet.getRangeByName('B1').setText(nombre);
    sheet.getRangeByName('B2').setText(telefono);
    sheet.getRangeByName('B3').setText(email);
    sheet.getRangeByName('B4').setText(descripcion);

    sheet.getRangeByName('A7').setText('Sello');
    sheet.getRangeByName('B7').setText('Descripción');
    sheet.getRangeByName('C7').setText('Cantidad');

    for (var note = 0; note < productosExcel.length; note++) {
      CartModel noteActual = productosExcel[note];
      var gato = note + 8;
      sheet.getRangeByName('A$gato').setText(noteActual.nombre);
      sheet.getRangeByName('B$gato').setText(noteActual.descripcion);
      sheet.getRangeByName('C$gato').setText(noteActual.cantidad.toString());
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final String rutaArchivo =
        (await path.getApplicationSupportDirectory()).path;
    final String fileName = '$rutaArchivo/cotizacion.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    //open.OpenFile.open(fileName);

    final enviarCorreo = await sendMail(fileName, nombre);
  }

  sendMail(String path, String nombre) async {
    
    String username = 'app@fri.com.mx';
    String password = 'Th3KHEeXKaxA';
    String domainSmtp = 'mail.totalseals.com.mx';


    //user for your own domain
    final smtpServer = SmtpServer(domainSmtp,
        username: username, password: password, port: 587);

    final message = Message()
      ..from = Address(username, 'App FRI')
      ..recipients.add('monterrey@fri.com.mx')
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Cotizacion de App FRI'
      ..html =
          "<p>Se adjunta el archivo excel con la cotizacion solicitada por el cliente.</p>"
      ..attachments = [FileAttachment(File(path))];

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Widget _crearNombreProyecto() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        initialValue: nombre ?? "",
        keyboardType: TextInputType.text,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onSaved: (value) => nombre = value!,
        validator: (value) {},
      ),
    );
  }

  Widget _crearCorreo() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        initialValue: email ?? "",
        keyboardType: TextInputType.text,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onSaved: (value) => email = value!,
        validator: (value) {},
      ),
    );
  }

  Widget _crearTelefono() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        initialValue: telefono ?? "",
        keyboardType: TextInputType.text,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onSaved: (value) => telefono = value!,
        validator: (value) {},
      ),
    );
  }

  Widget _crearComentario() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        initialValue: descripcion ?? "",
        maxLines: 9,
        minLines: 7,
        keyboardType: TextInputType.text,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onSaved: (value) => descripcion = value!,
      ),
    );
  }
}

