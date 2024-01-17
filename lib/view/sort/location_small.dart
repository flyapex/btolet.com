// import 'package:btolet/controller/location_controller.dart';
// import 'package:btolet/view/map/location_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

// class LocationSmall extends StatelessWidget {
//   const LocationSmall({super.key});

//   @override
//   Widget build(BuildContext context) {
//     LocationController locationController = Get.put(LocationController());
//     return Container(
//       color: Colors.white,
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () => Get.to(
//             () => const LocationSheet(),
//             duration: const Duration(milliseconds: 170),
//             transition: Transition.circularReveal,
//             fullscreenDialog: true,
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: const Color(0xffEEEEEE),
//                         child: SvgPicture.asset(
//                           'assets/icons/home/location.svg',
//                           height: 18,
//                           width: 18,
//                           // ignore: deprecated_member_use
//                           color: Colors.blue,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       SizedBox(
//                         width: Get.width / 1.5,
//                         child: Text(
//                           locationController.locationAddress.value,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             letterSpacing: 0.1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: SvgPicture.asset(
//                       'assets/icons/home/arrow.svg',
//                       height: 12,
//                       width: 12,
//                       // ignore: deprecated_member_use
//                       color: const Color(0xffAFAFAF),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 25),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
