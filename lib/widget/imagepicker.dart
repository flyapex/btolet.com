import 'dart:io';

import 'package:btolet/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

class SelectImage extends StatefulWidget {
  final IconData icon;

  final int imagnumber;
  const SelectImage({
    required this.icon,
    Key? key,
    required this.imagnumber,
  }) : super(key: key);

  @override
  SelectImageState createState() => SelectImageState();
}

class SelectImageState extends State<SelectImage> {
  PostController postController = Get.find();

  final _picker = HLImagePickerAndroid();

  List<HLPickerItem> _selectedImages = [];

  Future<void> getImage() async {
    try {
      final images = await _picker.openPicker(
        cropping: false,
        // ignore: dead_code
        selectedIds: true ? _selectedImages.map((e) => e.id).toList() : null,
        pickerOptions: HLPickerOptions(
          mediaType: MediaType.image,
          enablePreview: true,
          // isExportThumbnail: _isExportThumbnail,
          thumbnailCompressFormat: CompressFormat.jpg,
          thumbnailCompressQuality: 0.9,
          recordVideoMaxSecond: 40,
          maxSelectedAssets: 10,
          usedCameraButton: true,
          numberOfColumn: 3,
        ),
      );
      setState(() {
        _selectedImages = images;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _selectedImages.isEmpty
            ? Row(
                children: [
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () async {
                        getImage();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff7F6BFC)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Select Image",
                              style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 0.8,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox(
                height: Get.height / 4,
                width: Get.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedImages.length,
                        itemBuilder: (_, index) {
                          File? imageFile = File(_selectedImages[index].path);
                          if (_selectedImages[index].type == "video") {
                            imageFile = _selectedImages[index].thumbnail != null
                                ? File(_selectedImages[index].thumbnail!)
                                : null;
                          }
                          return imageFile != null
                              ? InkWell(
                                  onTap: _selectedImages[index].type == "video"
                                      ? () {}
                                      : null,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Image.file(imageFile),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: ClipOval(
                                                child: Material(
                                                  color: const Color(0xff261C2C)
                                                      .withOpacity(0.5),
                                                  child: InkWell(
                                                    splashColor: Colors.white,
                                                    onTap: () {
                                                      setState(() {
                                                        _selectedImages
                                                            .removeAt(index);
                                                      });
                                                    },
                                                    child: SizedBox(
                                                      width: 27,
                                                      height: 27,
                                                      child: Icon(
                                                        Feather.x,
                                                        color: Colors.white
                                                            .withOpacity(
                                                          0.9,
                                                        ),
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  alignment: Alignment.center,
                                  width: 320,
                                  height: double.infinity,
                                  child: const Text('No thumbnail'));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(width: 8.0),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () async {
                                getImage();
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff7F6BFC)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Select Image",
                                      style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 0.8,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}










  // SizedBox(
  //                                       height: 240,
  //                                       width: double.infinity,
  //                                       child: ListView.separated(
  //                                         padding: const EdgeInsets.all(8),
  //                                         physics:
  //                                             const AlwaysScrollableScrollPhysics(),
  //                                         scrollDirection: Axis.horizontal,
  //                                         itemCount: _selectedImages.length,
  //                                         itemBuilder: (_, index) {
  //                                           File? imageFile = File(
  //                                               _selectedImages[index].path);
  //                                           if (_selectedImages[index].type ==
  //                                               "video") {
  //                                             imageFile = _selectedImages[index]
  //                                                         .thumbnail !=
  //                                                     null
  //                                                 ? File(_selectedImages[index]
  //                                                     .thumbnail!)
  //                                                 : null;
  //                                           }
  //                                           return imageFile != null
  //                                               ? InkWell(
  //                                                   onTap:
  //                                                       _selectedImages[index]
  //                                                                   .type ==
  //                                                               "video"
  //                                                           ? () {}
  //                                                           : null,
  //                                                   child:
  //                                                       Image.file(imageFile))
  //                                               : Container(
  //                                                   decoration: BoxDecoration(
  //                                                     color: Colors.grey[300],
  //                                                     borderRadius:
  //                                                         BorderRadius.circular(
  //                                                             4),
  //                                                   ),
  //                                                   alignment: Alignment.center,
  //                                                   width: 320,
  //                                                   height: double.infinity,
  //                                                   child: const Text(
  //                                                       'No thumbnail'));
  //                                         },
  //                                         separatorBuilder:
  //                                             (BuildContext context,
  //                                                     int index) =>
  //                                                 const SizedBox(width: 8.0),
  //                                       ),
  //                                     ),