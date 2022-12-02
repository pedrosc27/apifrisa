import 'package:api/ui/pages/buscar/buscar_page.dart';
import 'package:api/ui/pages/carrito/carrito_page.dart';
import 'package:api/ui/pages/home/home.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const BuscarPage(),
    const CarritoPage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x00ffffff),
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Container(
        
      
        child: Container(
          color: Color(0x00ffffff),
          child:  BottomNavigationBar(
            
            elevation: 0.0,
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
            backgroundColor: Color(0x00ffffff),
            selectedItemColor: amarilloFrisa,
            unselectedItemColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Chats',
                  backgroundColor: negroFrisa),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Calls',
                  backgroundColor: negroFrisa),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Camera',
                  backgroundColor: negroFrisa),
            ],
          ),
        ),
      ),
    );
    
    
    

  }
}
