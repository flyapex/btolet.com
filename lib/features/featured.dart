// class Posts extends StatelessWidget {
//   const Posts({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var height = Get.height;
//     var width = Get.width;
//     return Container(
//         height: height / 7,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: const [
//             BoxShadow(color: Colors.black12, spreadRadius: 1.1),
//           ],
//         ),
//         child: Stack(
//           alignment: Alignment.centerRight,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   width: width / 2.8,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       bottomLeft: Radius.circular(10),
//                     ),
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           'https://images.unsplash.com/photo-1501183638710-841dd1904471?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       bottomLeft: Radius.circular(10),
//                     ),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//                       child: Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.withOpacity(0.1),
//                           image: const DecorationImage(
//                             image: NetworkImage(
//                                 'https://images.unsplash.com/photo-1501183638710-841dd1904471?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 7,
//                   color: Colors.yellowAccent,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.only(left: 5, right: 5),
//                         decoration: BoxDecoration(
//                           color: Colors.yellowAccent,
//                           borderRadius: BorderRadius.circular(2),
//                         ),
//                         child: const Row(
//                           children: [
//                             Icon(
//                               Icons.flash_on,
//                               size: 12,
//                             ),
//                             Text(
//                               "FEATURED",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Color(0xff083437),
//                                 fontWeight: FontWeight.w300,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Text(
//                         "৳ 2000",
//                         style: TextStyle(
//                           fontSize: 22,
//                           color: Color(0xff083437),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       // const Text(
//                       //   "2 Bds -2 Ba -1234 ft2",
//                       //   style: TextStyle(
//                       //     color: Color(0xff083437),
//                       //     fontSize: 12,
//                       //   ),
//                       // ),
//                       const Row(
//                         children: [
//                           Text(
//                             "2 ",
//                             style: TextStyle(
//                               color: Color(0xff083437),
//                               fontSize: 14,
//                             ),
//                           ),
//                           Icon(Icons.bed_outlined, color: Colors.black38),
//                           Text(
//                             "  2",
//                             style: TextStyle(
//                               color: Color(0xff083437),
//                               fontSize: 14,
//                             ),
//                           ),
//                           Icon(Icons.shower_outlined, color: Colors.black38),
//                           Text(
//                             "  123 ",
//                             style: TextStyle(
//                               color: Color(0xff083437),
//                               fontSize: 14,
//                             ),
//                           ),
//                           Icon(
//                             Icons.image_aspect_ratio_rounded,
//                             color: Colors.black38,
//                           ),
//                         ],
//                       ),
//                       // Text(
//                       //   "House For Rent",
//                       //   style: TextStyle(
//                       //     color: const Color(0xff083437).withOpacity(0.3),
//                       //     fontSize: 12,
//                       //   ),
//                       // ),
//                       Text(
//                         "Khulna Nirala",
//                         style: TextStyle(
//                           color: const Color(0xff083437).withOpacity(0.3),
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   // const Icon(
//                   //   Icons.favorite_border_outlined,
//                   //   color: Color(0xff083437),
//                   //   size: 26,
//                   // ),
//                   LikeButton(
//                     size: 26,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     circleColor: const CircleColor(
//                       start: Color(0xff00ddff),
//                       end: Color(0xff0099cc),
//                     ),
//                     bubblesColor: const BubblesColor(
//                       dotPrimaryColor: Color(0xff33b5e5),
//                       dotSecondaryColor: Color(0xff0099cc),
//                     ),
//                     // likeCount: 665,
//                     likeBuilder: (bool isLiked) {
//                       return Icon(
//                         isLiked
//                             ? Icons.favorite
//                             : Icons.favorite_border_outlined,
//                         color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
//                       );
//                     },
//                     animationDuration: const Duration(milliseconds: 400),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     "1 day ago",
//                     style: TextStyle(
//                       color: const Color(0xff083437).withOpacity(0.3),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
// }
