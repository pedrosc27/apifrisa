import 'package:api/database/db.dart';
import 'package:api/domain/models/cart_model.dart';
import 'package:flutter/cupertino.dart';

class CarritoProvider extends ChangeNotifier {
  List<CartModel> listaCarrito = [];
  bool cargado = false;
  final NotesDatabase database = NotesDatabase.instance;

  Future<void> agregarProducto(CartModel productoCarrito) async {
    final id = await database.create(productoCarrito);
    final newCarrito = CartModel(
        nombre: productoCarrito.nombre,
        imagen: productoCarrito.imagen,
        descripcion: productoCarrito.descripcion,
        cantidad: productoCarrito.cantidad,
        id: id);
    listaCarrito.add(newCarrito);
    notifyListeners();
  }

  Future<void> cargarCarrito() async {
    listaCarrito = await database.readAllNotes();
    cargado = true;
    notifyListeners();
  }

  void borrarProducto(int id) async {
    database.delete(id);
    listaCarrito.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> borrarTodosLosProductos() async{
    final borrar = await database.deleteAll();
    listaCarrito = [];
    notifyListeners();
  }
}
