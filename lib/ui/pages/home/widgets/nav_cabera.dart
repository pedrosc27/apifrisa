import 'package:api/ui/pages/filtros/filter.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';

class NavCabecera extends StatefulWidget {
  const NavCabecera({Key? key}) : super(key: key);

  @override
  State<NavCabecera> createState() => _NavCabecera();
}

class _NavCabecera extends State<NavCabecera> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: amarilloFrisa,
      padding: const EdgeInsets.only(top: 16, bottom: 26, right: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/frisa.png",
            width: 120,
          ),
          GestureDetector(
            onTap: (() {
              Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const FiltrosPage()));
            }),
            child: Container(
              height: 65,
              width: 65,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/images/filter.png"),
            ),
          )
        ],
      ),
    );
  }
}
