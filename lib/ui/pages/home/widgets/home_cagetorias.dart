import 'package:api/ui/pages/home/widgets/columnados.dart';
import 'package:api/ui/pages/home/widgets/columnauno.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';

class CategoriasHome extends StatelessWidget {
  const CategoriasHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: grisFrisa, borderRadius: BorderRadius.circular(10)),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 10,
              ),
              Text(
                "Categorías",
                style: TextStyle(
                    fontSize: 18,
                    color: negroFrisa,
                    fontFamily: 'NeoMedium',
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              ColumnaUno(),
              SizedBox(
                height: 20,
              ),
              ColumnaDos()
            ],
          ),
        ),
      ),
    );
  }
}
