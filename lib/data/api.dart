import 'dart:io';

import 'package:api/domain/models/product_model.dart';
import 'package:api/domain/repository/api_repository.dart';
import 'package:dio/dio.dart';

class ApiProvider extends ApiRepository {
  final String _url = 'https://www.fri.com.mx/api/wp-json/wc/v3/';
  final String _ck = 'ck_5b58ada768ee4965512a05256ea1598280c504e4';
  final String _cs = 'cs_3554796479b33c49c5fc5deb0c1b6dd248be5283';

  @override
  Future<List<Producto>> getProductsByCategories() async {
    List<Producto> productos = [];
    String parameter = "&per_page=40";

    try {
      var response = await Dio().get(
        _url +
            'products?category=157,154,159' +
            '&consumer_key=' +
            _ck +
            '&consumer_secret=' +
            _cs +
            parameter,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "aplication/json"}),
      );
      if (response.statusCode == 200) {
        final data =
            (response.data as List).map((e) => Producto.fromJson(e)).toList();
        productos = data;
      }
    } catch (e) {
      print('error aqui 1: $e');
    }

    return productos;
  }

  @override
  Future<List<Producto>> getProductsByIds(List<int> ids) async {
    List<Producto> productos = [];
    String parameter = '&include=';
    String nuevo = '';
    for (var i = 0; i < ids.length; i++) {
      nuevo = nuevo + ids[i].toString() + ',';
    }
    parameter = parameter + nuevo;
    try {
      var response = await Dio().get(
        _url +
            'products?' +
            'consumer_key=' +
            _ck +
            '&consumer_secret=' +
            _cs +
            parameter,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "aplication/json"}),
      );
      if (response.statusCode == 200) {
        final data =
            (response.data as List).map((e) => Producto.fromJson(e)).toList();
        productos = data;
      }
    } catch (e) {
      print('error aqui 2: $e');
    }

    return productos;
  }

  @override
  Future<List<Producto>> getProductsByCategory(id) async {
    List<Producto> productos = [];
    String parameter = "&per_page=70";

    try {
      var response = await Dio().get(
        _url +
            'products?category=$id' +
            '&consumer_key=' +
            _ck +
            '&consumer_secret=' +
            _cs +
            parameter,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "aplication/json"}),
      );
      if (response.statusCode == 200) {
        final data =
            (response.data as List).map((e) => Producto.fromJson(e)).toList();
        productos = data;
      }
    } catch (e) {
      print('error aqui 3: $e');
    }

    return productos;
  }
}
//asi se obtienen los productos
//https://www.fri.com.mx/api/wp-json/wc/v3/products?consumer_key=ck_5b58ada768ee4965512a05256ea1598280c504e4&consumer_secret=cs_3554796479b33c49c5fc5deb0c1b6dd248be5283
//asi se obtiene la info de un producto
//https://www.fri.com.mx/api/wp-json/wc/v3/products/439?consumer_key=ck_5b58ada768ee4965512a05256ea1598280c504e4&consumer_secret=cs_3554796479b33c49c5fc5deb0c1b6dd248be5283
//asi se obtienen productos de varias categorias al mismo tiempo
//https://www.fri.com.mx/api/wp-json/wc/v3/products?category=157,154,159&consumer_key=ck_5b58ada768ee4965512a05256ea1598280c504e4&consumer_secret=cs_3554796479b33c49c5fc5deb0c1b6dd248be5283
//asi se obtienen la info  de las categorias relacionadas a una categoria en especifico
//https://www.fri.com.mx/api/wp-json/wc/v3/products/categories?consumer_key=ck_5b58ada768ee4965512a05256ea1598280c504e4&consumer_secret=cs_3554796479b33c49c5fc5deb0c1b6dd248be5283&parent=159
