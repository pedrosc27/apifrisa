import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';

class ErrorVertical extends StatelessWidget {
  const ErrorVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: 20,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 256,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (_, index) => Container(
        width: 150,
        decoration: BoxDecoration(
            color: grisVazel, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.error,
              size: 40,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Error',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'NeoRegular',
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
