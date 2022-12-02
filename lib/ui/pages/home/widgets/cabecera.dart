import 'package:api/ui/pages/home/widgets/buscar.dart';
import 'package:api/ui/pages/home/widgets/nav_cabera.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';

class Cabecera extends StatelessWidget {
  const Cabecera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: amarilloFrisa,
      child: Column(
        children: const [
          NavCabecera(),
          Buscar(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
