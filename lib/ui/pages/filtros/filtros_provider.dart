import 'package:api/data/api.dart';
import 'package:api/domain/models/filtro_model.dart';
import 'package:api/domain/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class FiltrosProvider extends ChangeNotifier {
  final ApiProvider api = ApiProvider();
  List<Producto> productos = [];
  List<FiltroModel> seleccionados = [];
  bool cargado = false;
  int id = 159;

  void setSeleccionados(List<FiltroModel> selecionadosNuevos) {
    seleccionados = selecionadosNuevos;
    notifyListeners();
  }

  void resetCargado(){
    cargado = false;
    notifyListeners();
  }
  Future<void> getProductsByCategories() async {
    List<Producto> data = await api.getProductsByCategory(id);
    List<Producto> resultados = [];

    for (var i = 0; i < data.length; i++) {
      int suma = 0;
      for (var j = 0; j < seleccionados.length; j++) {
        if (j == 0) {
          suma = 0;
        }
        final producto = data[i];

        List<Attribute>? atributos = producto.attributes
            ?.where((element) => element.id == seleccionados[j].id)
            .toList();

        final cantidadAtributos = atributos?.length;

        if (cantidadAtributos != 0) {
          if (atributos![0].options != null) {
            final terms = atributos
                .where((element) =>
                    element.options!.contains(seleccionados[j].nombre))
                .toList();

            final cantidadTerms = terms.length;
            if (cantidadTerms == 0) {
              // print("SE EJECUTA TERMS TERMS : ${cantidadTerms}");
              suma = -1;
            } else {}
          }
        } else {
          suma = -1;
        }
        final valorJ = seleccionados.length - 1;

        if (j == valorJ) {
          if (suma != -1) {
            resultados.add(producto);
          }
        }
      }
    }

    productos = resultados;
    cargado = true;
    notifyListeners();
  }
}
