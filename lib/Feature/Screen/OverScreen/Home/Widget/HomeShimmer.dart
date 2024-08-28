import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer effect for user profile picture and username
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.white,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    height: 20.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Shimmer effect for post image
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.white,
            ),
          ),
          // Shimmer effect for like and comment buttons
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Container(
                  width: 80.0,
                  height: 20.0,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 80.0,
                  height: 20.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          // Shimmer effect for post description
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 20.0,
              color: Colors.white,
            ),
          ),
          // Shimmer effect for comments
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 12.0,
                  color: Colors.white,
                ),
                SizedBox(height: 4.0),
                Container(
                  height: 12.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
