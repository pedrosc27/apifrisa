import 'dart:convert';

import 'package:api/domain/models/attribute_terms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AttributeTermsProvider extends ChangeNotifier {
  List<AttributeTermsFilter> attributeTerms = [];
  Future<void> readJson() async {
    final response = await rootBundle.loadString('assets/attribute_terms.json');
    final data = json.decode(response);

    List<AttributeTermsFilter> mapa = data
        .map<AttributeTermsFilter>((s) => AttributeTermsFilter.fromJson(s))
        .toList();

    mapa = data
        .map<AttributeTermsFilter>((s) => AttributeTermsFilter.fromJson(s))
        .toList();

    attributeTerms = mapa;
    notifyListeners();
  }
}
