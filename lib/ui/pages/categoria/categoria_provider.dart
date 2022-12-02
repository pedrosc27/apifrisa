import 'package:api/data/api.dart';
import 'package:api/domain/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class CategoriaProvider extends ChangeNotifier {
  final ApiProvider api = ApiProvider();
  List<CategoryModel> childCategoryIds = [];
  List<Producto> productos = [];

  void setChildCategory(List<CategoryModel> categories) {
    childCategoryIds = categories;
    notifyListeners();
  }

  Future<void> getProductsByCategory(int id) async {
    productos = await api.getProductsByCategory(id);
    notifyListeners();
  }

  void setProductos() {
    productos = [];
    notifyListeners();
  }
}
