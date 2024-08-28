// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:campuslink/Util/util.dart';

// class CustomGnav extends StatelessWidget {
//   final int index;
//   final void Function(int) onTabChange;
//   const CustomGnav({
//     super.key,
//     required this.index,
//     required this.onTabChange

//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 20,
//               color: Colors.black.withOpacity(.1),
//             )
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//             child: GNav(
//               rippleColor:  themeColor.appThemeColor.withOpacity(0.5),
//               hoverColor: Colors.grey[100]!,
//               gap: 8,
//               activeColor: Colors.white,
//               iconSize: 24,
//               curve: Curves.fastEaseInToSlowEaseOut,
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//               duration: const Duration(milliseconds: 400),
//               tabBackgroundColor: themeColor.appThemeColor,
//               color: themeColor.appThemeColor,
//               tabs: const [
//                 GButton(
//                   icon: Icons.public,
//                   text: 'Explore',
//                 ),
//                 GButton(
//                   icon: Icons.insert_comment_outlined,
//                   text: 'Request',
//                 ),
//                 GButton(
//                   icon: Icons.schedule,
//                   text: 'Time Table',
//                 ),
//                 GButton(
//                   icon: Icons.rocket_launch_outlined,
//                   text: 'Profile',
//                 ),
//               ],
//               selectedIndex: index,
//               onTabChange: onTabChange,
//             ),
//           ),
//         ),
//       );
//   }
// }