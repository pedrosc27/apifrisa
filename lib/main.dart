import 'package:api/ui/global_controllers/attribute_terms_controller.dart';
import 'package:api/ui/pages/buscar/buscar_provider.dart';
import 'package:api/ui/pages/carrito/carrito_provider.dart';
import 'package:api/ui/pages/categoria/categoria_provider.dart';
import 'package:api/ui/pages/filtros/filtros_provider.dart';
import 'package:api/ui/pages/home/home_provider.dart';
import 'package:api/ui/pages/navigation/navigation.dart';
import 'package:api/ui/pages/navigation/navigation_provider.dart';
import 'package:api/ui/pages/producto/producto_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<ProductoPageProvider>(create: ((context) => ProductoPageProvider())),
        ChangeNotifierProvider<CategoriaProvider>(create: ((context) => CategoriaProvider())),
        ChangeNotifierProvider<AttributeTermsProvider>(create: ((context) => AttributeTermsProvider())),
        ChangeNotifierProvider<CarritoProvider>(create: ((context) => CarritoProvider())),
        ChangeNotifierProvider<NavigationProvider>(create: ((context) => NavigationProvider())),
        ChangeNotifierProvider<BuscarProvider>(create: ((context) => BuscarProvider())),
        ChangeNotifierProvider<FiltrosProvider>(create: ((context) => FiltrosProvider()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FRISA',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NavigationPage(),
      ),
    );
  }
}
