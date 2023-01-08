import 'package:flutter/cupertino.dart';

class NavigationProvider extends ChangeNotifier{

  int selected = 0;

  void setSelected(int id){
    selected = id;
    notifyListeners();
  }
}