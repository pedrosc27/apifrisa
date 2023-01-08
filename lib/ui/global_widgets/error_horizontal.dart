import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';


class ErrorHorizontal extends StatelessWidget {
  const ErrorHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        separatorBuilder: ((context, index) => const SizedBox(
              width: 11,
            )),
        itemBuilder: (_, __) => Container(
          width: 150,
          decoration: BoxDecoration(
              color: grisVazel, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.error, size: 40,),
              SizedBox(height: 8,),
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
      ),
    );
  }
}
