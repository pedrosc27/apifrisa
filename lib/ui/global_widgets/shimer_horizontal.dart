import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHorizontal extends StatelessWidget {
  const ShimmerHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Shimmer.fromColors(
        baseColor: grisVazel,
        highlightColor: Colors.grey.withOpacity(0.1),
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
          ),
        ),
      ),
    );
  }
}
