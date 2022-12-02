// To parse this JSON data, do
//
//     final producto = productoFromJson(jsonString);

import 'dart:convert';

Producto productoFromJson(String str) => Producto.fromJson(json.decode(str));

String productoToJson(Producto data) => json.encode(data.toJson());

class Producto {
    Producto({
        this.id,
        this.name,
        this.slug,
        this.permalink,
        this.type,
        this.status,
        this.description,
        this.shortDescription,
        this.priceHtml,
        this.relatedIds,
        this.categories,
        this.tags,
        this.images,
        this.attributes,
    });

    int? id;
    String? name;
    String? slug;
    String? permalink;
    String? type;
    String? status;
    String? description;
    String? shortDescription;
    String? priceHtml;
    List<int>? relatedIds;
    List<CategoryModel>? categories = [];
    List<dynamic>? tags;
    List<ImageProduct>? images;
    List<Attribute>? attributes;

    factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        permalink: json["permalink"],
        type: json["type"],
        status: json["status"],
        description: json["description"],
        shortDescription: json["short_description"],
        priceHtml: json["price_html"],
        relatedIds: json["related_ids"] == null
            ? null
            :  List<int>.from(json["related_ids"].map((x) => x)),
        categories: json["categories"] == null
            ? null
            : List<CategoryModel>.from(json["categories"].map((x) => CategoryModel.fromJson(x))),
        tags: json["tags"] == null
            ? null
            :  List<dynamic>.from(json["tags"].map((x) => x)),
        images: json["images"] == null
            ? null
            :  List<ImageProduct>.from(json["images"].map((x) => ImageProduct.fromJson(x))),
        attributes: json["attributes"] == null
            ? null
            :  List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "permalink": permalink,
        "type": type,
        "status": status,
        "description": description,
        "short_description": shortDescription,
        "price_html": priceHtml,
        "related_ids":relatedIds == null
            ? null
            :  List<dynamic>.from(relatedIds!.map((x) => x)),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "tags": tags == null
            ? null
            : List<dynamic>.from(tags!.map((x) => x)),
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
    };
}

class Attribute {
    Attribute({
        this.id,
        this.name,
        this.variation,
        this.options,
    });

    int? id;
    String? name;
    bool? variation;
    List<String>? options;

    factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        name: json["name"],
        variation: json["variation"],
        options:  json["options"] == null
            ? null
            : List<String>.from(json["options"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "variation": variation,
        "options": options == null ? null : List<dynamic>.from(options!.map((x) => x)),
    };
}

class CategoryModel {
    CategoryModel({
        this.id,
        this.name,
        this.slug,
    });

    int? id;
    String? name;
    String? slug;

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
    };
}

class ImageProduct {
    ImageProduct({
        this.id,
        this.src,
    });

    int? id;
    String? src;

    factory ImageProduct.fromJson(Map<String, dynamic> json) => ImageProduct(
        id: json["id"],
        src: json["src"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
    };
}
