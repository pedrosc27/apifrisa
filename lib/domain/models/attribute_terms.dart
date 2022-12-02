class AttributeTermsFilter {
  
  AttributeTermsFilter({this.id, this.name, this.parent});

  int? id;
  String? name;
  int? parent;
  

  factory AttributeTermsFilter.fromJson(Map<String, dynamic> json) =>
      AttributeTermsFilter(id: json["id"], name: json["name"], parent: json["parent"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent": parent,
      };
}
