import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class ShimerVertical extends StatelessWidget {
  const ShimerVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: grisVazel,
      highlightColor: Colors.grey.withOpacity(0.1),
      child: GridView.builder(
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
        ),
      ),
    );
  }
}
