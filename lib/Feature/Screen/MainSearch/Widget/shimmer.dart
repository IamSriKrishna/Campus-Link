import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
class ListTileShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverStaggeredGrid.countBuilder(
      itemCount: 999,
    crossAxisCount: 3,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: const Color.fromARGB(179, 158, 158, 158),
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color.fromARGB(146, 255, 255, 255),
          ),
        ),
      );
    },
    staggeredTileBuilder: (index) => StaggeredTile.count(
      (index % 7 == 0) ? 2 : 1,
      (index % 7 == 0) ? 2 : 1,
    ),
    mainAxisSpacing: 4.0,
    crossAxisSpacing: 4.0,
  );
  }
}