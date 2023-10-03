// import 'dart:io';

// import 'package:btolet/controller/post_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class SelectImage extends StatefulWidget {
//   final IconData icon;

//   final int imagnumber;
//   const SelectImage({
//     required this.icon,
//     Key? key,
//     required this.imagnumber,
//   }) : super(key: key);

//   @override
//   SelectImageState createState() => SelectImageState();
// }

// class SelectImageState extends State<SelectImage> {
//   PostController postController = Get.find();

//   final List<XFile> _images = [];

//   // ignore: prefer_typing_uninitialized_variables
//   // var selectedImage;
//   final picker = ImagePicker();

//   Future<void> getImage() async {
//     if (_images.length >= 10) {
//       showASnackBarOrDialogThatUserNotAlowwedMoreThan10();
//       return;
//     }

//     final List<XFile> selectedImages = await picker.pickMultiImage(
//       imageQuality: 25,
//     );

//     if (selectedImages.isNotEmpty) {
//       // Check if the total number of images will exceed 10 after adding the new images
//       if (_images.length + selectedImages.length <= 10) {
//         _images.addAll(selectedImages);
//         setState(() {});
//       } else {
//         // Show a message that the maximum number of images is 10
//         showASnackBarOrDialogThatUserNotAlowwedMoreThan10();
//       }
//     }
//   }

//   void showASnackBarOrDialogThatUserNotAlowwedMoreThan10() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('You can select a maximum of 10 images.'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _images.isEmpty
//             ? Row(
//                 children: [
//                   SizedBox(
//                     height: 44,
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         getImage();
//                       },
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all(const Color(0xff7F6BFC)),
//                       ),
//                       child: const Padding(
//                         padding: EdgeInsets.only(left: 20, right: 20),
//                         child: Row(
//                           children: <Widget>[
//                             Icon(
//                               Icons.add_a_photo,
//                               color: Colors.white,
//                             ),
//                             SizedBox(width: 10),
//                             Text(
//                               "Select Image",
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 letterSpacing: 0.8,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             : SizedBox(
//                 height: Get.height / 4,
//                 width: Get.width,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: _images.length,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (context, index) {
//                           return SizedBox(
//                             height: Get.height / 4,
//                             width: Get.width / 3,
//                             child: Stack(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Stack(
//                                     alignment: Alignment.topRight,
//                                     children: [
//                                       Image.file(
//                                         File(_images[index].path),
//                                         fit: BoxFit.contain,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(5.0),
//                                         child: ClipOval(
//                                           child: Material(
//                                             color: const Color(0xff261C2C)
//                                                 .withOpacity(0.5),
//                                             child: InkWell(
//                                               splashColor: Colors.white,
//                                               onTap: () {
//                                                 setState(() {
//                                                   _images.removeAt(index);
//                                                 });
//                                               },
//                                               child: SizedBox(
//                                                 width: 27,
//                                                 height: 27,
//                                                 child: Icon(
//                                                   Feather.x,
//                                                   color:
//                                                       Colors.white.withOpacity(
//                                                     0.9,
//                                                   ),
//                                                   size: 20,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(
//                             height: 44,
//                             // ignore: deprecated_member_use
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 getImage();
//                               },
//                               style: ButtonStyle(
//                                 backgroundColor: MaterialStateProperty.all(
//                                     const Color(0xff7F6BFC)),
//                               ),
//                               // elevation: 0,
//                               // padding: EdgeInsets.zero,
//                               // color: Colors.white,
//                               // shape: RoundedRectangleBorder(
//                               //   borderRadius: BorderRadius.circular(4),
//                               //   side: BorderSide(color: Colors.black.withOpacity(0.4)),
//                               // ),

//                               child: const Padding(
//                                 padding: EdgeInsets.only(left: 20, right: 20),
//                                 child: Row(
//                                   children: <Widget>[
//                                     Icon(
//                                       Icons.add_a_photo,
//                                       color: Colors.white,
//                                       // color: Color(0xff7F6BFC),
//                                     ),
//                                     SizedBox(width: 10),
//                                     Text(
//                                       "Select Image",
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         letterSpacing: 0.8,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//       ],
//     );
//   }
// }
