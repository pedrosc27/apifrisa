import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';

class CarritoVacio extends StatelessWidget {
  const CarritoVacio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: const [
          Icon(
            Icons.shopping_cart,
            size: 80,
            color: amarilloFrisa,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Tu Carrito esta vacío",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'NeoMedium',
                color: negroFrisa,
                fontWeight: FontWeight.w400),
          ),
        ]),
      ),
    );
  }
}
