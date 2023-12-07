import 'dart:io';

import 'package:btolet/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

class SelectImageFloorPlan extends StatefulWidget {
  final IconData icon;

  final int imagnumber;
  final Color color;
  const SelectImageFloorPlan({
    super.key,
    required this.icon,
    required this.imagnumber,
    required this.color,
  });

  @override
  State<SelectImageFloorPlan> createState() => _SelectImageFloorPlanState();
}

class _SelectImageFloorPlanState extends State<SelectImageFloorPlan> {
  PostController postController = Get.find();

  final _picker = HLImagePickerAndroid();

  Future<void> getImage() async {
    try {
      final images = await _picker.openPicker(
        cropping: false,
        // ignore: dead_code
        selectedIds: true
            ? postController.selectedFloorplanImages.map((e) => e.id).toList()
            // ignore: dead_code
            : null,
        pickerOptions: HLPickerOptions(
          mediaType: MediaType.image,
          enablePreview: false,
          // isExportThumbnail: _isExportThumbnail,
          thumbnailCompressFormat: CompressFormat.jpg,
          thumbnailCompressQuality: 1,
          recordVideoMaxSecond: 60,
          maxSelectedAssets: widget.imagnumber,
          usedCameraButton: true,
          numberOfColumn: 3,
        ),
      );
      setState(() {
        postController.selectedFloorplanImages = images;
        postController.selectedFloorplanImages;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        postController.selectedFloorplanImages.isEmpty
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
                            MaterialStateProperty.all(widget.color),
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
                        itemCount:
                            postController.selectedFloorplanImages.length,
                        itemBuilder: (_, index) {
                          File? imageFile = File(postController
                              .selectedFloorplanImages[index].path);
                          if (postController
                                  .selectedFloorplanImages[index].type ==
                              "video") {
                            imageFile = postController
                                        .selectedFloorplanImages[index]
                                        .thumbnail !=
                                    null
                                ? File(postController
                                    .selectedFloorplanImages[index].thumbnail!)
                                : null;
                          }
                          return imageFile != null
                              ? InkWell(
                                  onTap: postController
                                              .selectedFloorplanImages[index]
                                              .type ==
                                          "video"
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
                                                        postController
                                                            .selectedFloorplanImages
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
                      postController.selectedFloorplanImages.length != 1
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
                                          MaterialStateProperty.all(
                                              const Color(0xff7F6BFC)),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
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
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}

class SelectImageProperty extends StatefulWidget {
  final IconData icon;

  final int imagnumber;
  const SelectImageProperty({
    required this.icon,
    Key? key,
    required this.imagnumber,
    required Color color,
  }) : super(key: key);

  @override
  SelectImagePropertyState createState() => SelectImagePropertyState();
}

class SelectImagePropertyState extends State<SelectImageProperty> {
  PostController postController = Get.find();

  final _picker = HLImagePickerAndroid();

  Future<void> getImage() async {
    try {
      final images = await _picker.openPicker(
        cropping: false,
        selectedIds: true
            ? postController.selectedPropertyImages.map((e) => e.id).toList()
            // ignore: dead_code
            : null,
        pickerOptions: HLPickerOptions(
          mediaType: MediaType.image,
          enablePreview: false,
          // isExportThumbnail: _isExportThumbnail,
          thumbnailCompressFormat: CompressFormat.jpg,
          thumbnailCompressQuality: 1,
          recordVideoMaxSecond: 60,
          maxSelectedAssets: widget.imagnumber,
          usedCameraButton: true,
          numberOfColumn: 3,
        ),
      );
      setState(() {
        postController.selectedPropertyImages = images;
        postController.selectedPropertyImages;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        postController.selectedPropertyImages.isEmpty
            ? Row(
                children: [
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () async {
                        getImage();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            postController.flagActiveFlagProperty.value
                                ? postController.imageFlagProperty.value
                                    ? const Color(0xff7F6BFC)
                                    : Colors.red
                                : const Color(0xff7F6BFC)),
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
                        itemCount: postController.selectedPropertyImages.length,
                        itemBuilder: (_, index) {
                          File? imageFile = File(postController
                              .selectedPropertyImages[index].path);
                          if (postController
                                  .selectedPropertyImages[index].type ==
                              "video") {
                            imageFile = postController
                                        .selectedPropertyImages[index]
                                        .thumbnail !=
                                    null
                                ? File(postController
                                    .selectedPropertyImages[index].thumbnail!)
                                : null;
                          }
                          return imageFile != null
                              ? InkWell(
                                  onTap: postController
                                              .selectedPropertyImages[index]
                                              .type ==
                                          "video"
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
                                                        postController
                                                            .selectedPropertyImages
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
                      postController.selectedPropertyImages.length != 12
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
                                          MaterialStateProperty.all(
                                              const Color(0xff7F6BFC)),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
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
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
