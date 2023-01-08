import 'package:api/data/api.dart';
import 'package:api/domain/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class CategoriaProvider extends ChangeNotifier {
  final ApiProvider api = ApiProvider();
  List<CategoryModel> childCategoryIds = [];
  List<Producto> productos = [];
  bool cargado = false;

  void setChildCategory(List<CategoryModel> categories) {
    childCategoryIds = categories;
    notifyListeners();
  }

  Future<void> getProductsByCategory(int id) async {
    productos = await api.getProductsByCategory(id);
    cargado = true;
   
    notifyListeners();
  }

  void setProductos() {
    productos = [];
    cargado = false;
    notifyListeners();
  }
}
