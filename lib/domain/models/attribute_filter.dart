class AttributeFilter {
  
  AttributeFilter({this.id, this.name, this.slug});

  int? id;
  String? name;
  String? slug;

  factory AttributeFilter.fromJson(Map<String, dynamic> json) =>
      AttributeFilter(id: json["id"], name: json["name"], slug: json["slug"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };

  static List<AttributeFilter> attributeList = [
    AttributeFilter(id: 9, name: "Asientos"),
    AttributeFilter(id: 7, name: "Cara Rotativa"),
    AttributeFilter(id: 8, name: "Empaque"),
    AttributeFilter(id: 6, name: "Milímetros"),
    AttributeFilter(id: 10, name: "Partes Metalicas"),
    AttributeFilter(id: 4, name: "Pulgadas"),
  ];
}
