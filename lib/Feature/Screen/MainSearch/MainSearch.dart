import 'package:campuslink/Feature/Screen/MainSearch/Widget/Explore.dart';
import 'package:campuslink/Feature/Screen/MainSearch/Widget/MainSearchAppBar.dart';
import 'package:campuslink/Feature/Screen/MainSearch/Widget/shimmer.dart';
import 'package:campuslink/Feature/Service/postService.dart';
import 'package:campuslink/Model/post.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MainSearch extends StatefulWidget {
  const MainSearch({super.key});

  @override
  State<MainSearch> createState() => _MainSearchState();
}

class _MainSearchState extends State<MainSearch> {
  List<Post>? fetchpost;
  final AddPostService _postService = AddPostService();
  bool _isMounted = false;

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  fetchAllProducts() async {
    try {
      fetchpost = await _postService.DisplayAllForm(context: context);
      if (_isMounted) {
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _isMounted = true;
    fetchAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (fetchpost == null) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            MainSearchAppBar(),
            ListTileShimmer(),
          ],
        ),
      );
    } else {
      fetchpost!.shuffle();
      return Scaffold(
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
        slivers: [
          MainSearchAppBar(),
          fetchpost == null
              ? ListTileShimmer()
              : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 3,
                  itemCount: fetchpost!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => PostDetailsPage(
                            selectedIndex: index, posts: fetchpost!));
                      },
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: fetchpost![index].image_url[0].toString(),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors
                                  .white, // Ensure your shimmer effect has a background color
                            ),
                          ), // Placeholder widget while loading
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error), // Widget to display on error
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
                )
        ],
      ));
    }
  }
}
