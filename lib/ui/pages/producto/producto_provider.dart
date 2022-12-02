import 'package:api/data/api.dart';
import 'package:api/database/db.dart';
import 'package:api/domain/models/cart_model.dart';
import 'package:api/domain/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductoPageProvider extends ChangeNotifier {
  final ApiProvider _api = ApiProvider();
  List<Producto>? products;
  final NotesDatabase database = NotesDatabase.instance;

  Future<void> getProductsByIds(List<int> ids) async {
    products = await _api.getProductsByIds(ids);
    notifyListeners();
  }

  Future<void> agregarProducto( CartModel productoCarrito) async{
    final crear = await database.create(productoCarrito);
    print(crear);
  }
  
}
