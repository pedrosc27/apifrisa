import 'package:api/data/api.dart';
import 'package:api/domain/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  final ApiProvider api = ApiProvider();
  List<Producto> products = [];
  bool cargado = false;

  Future<void> getProductsByCategories() async {
    products = await api.getProductsByCategories();
    
    cargado = true;
    notifyListeners();
  }
  
}
