import 'package:api/data/api.dart';
import 'package:api/domain/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class BuscarProvider extends ChangeNotifier{
  List<Producto> productos = [];  
  final api = ApiProvider();
  bool cargado = false;
  
  Future<void> buscarProducto(String query) async{
    productos = await api.searchProducts(query);
    cargado = true;
    notifyListeners();
  }

  void resetProductos(){
    productos = [];
    cargado = false;
    notifyListeners();
  }
}