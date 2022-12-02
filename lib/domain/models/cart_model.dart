// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
    CartModel({
        this.id,
        this.nombre,
        this.imagen,
        this.descripcion,
        this.cantidad,
    });

    int? id;
    String? nombre;
    String? imagen;
    String? descripcion;
    int? cantidad;

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        nombre: json["nombre"],
        imagen: json["imagen"],
        descripcion: json["descripcion"],
        cantidad: json["cantidad"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "imagen": imagen,
        "descripcion": descripcion,
        "cantidad": cantidad,
    };
}
