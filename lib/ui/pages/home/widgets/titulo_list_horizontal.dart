import 'package:api/ui/utils/colors.dart';
import 'package:flutter/cupertino.dart';

class TituloListHorizontal extends StatelessWidget {
  final String titulo;
  const TituloListHorizontal({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.only(left: 32),
          child:  Text(
            titulo,
            style:const TextStyle(
                fontSize: 18,
                color: negroFrisa,
                fontFamily: 'NeoMedium',
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
