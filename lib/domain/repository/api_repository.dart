import 'package:api/domain/models/product_model.dart';

abstract class ApiRepository{
  Future<List<Producto>> getProductsByCategories();
  Future<List<Producto>> getProductsByIds(List<int> ids);
  Future<List<Producto>> getProductsByCategory(id);
}