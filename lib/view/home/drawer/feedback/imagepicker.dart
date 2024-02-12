import 'dart:io';
import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

class ImagePickerFeedback extends StatefulWidget {
  final int imagnumber;
  const ImagePickerFeedback({
    Key? key,
    required this.imagnumber,
  }) : super(key: key);

  @override
  ImagePickerFeedbackState createState() => ImagePickerFeedbackState();
}

class ImagePickerFeedbackState extends State<ImagePickerFeedback> {
  UserController userController = Get.find();
  final _picker = HLImagePickerAndroid();

  Future<void> getImage() async {
    try {
      final images = await _picker.openPicker(
        cropping: false,
        selectedIds: userController.selectedImages.map((e) => e.id).toList(),
        pickerOptions: HLPickerOptions(
          mediaType: MediaType.image,
          enablePreview: false,
          thumbnailCompressFormat: CompressFormat.jpg,
          thumbnailCompressQuality: 1,
          maxSelectedAssets: widget.imagnumber,
          usedCameraButton: true,
          numberOfColumn: 3,
        ),
      );
      setState(() {
        userController.selectedImages = images;
        userController.selectedImages;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        userController.selectedImages.isEmpty
            ? InkWell(
                onTap: () {
                  getImage();
                },
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: const Color(0xffE3E8FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Feather.camera,
                        color: Colors.black38,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Select Image",
                        style: TextStyle(
                          fontSize: s2,
                          letterSpacing: 0.8,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
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
                        itemCount: userController.selectedImages.length,
                        itemBuilder: (_, index) {
                          File? imageFile =
                              File(userController.selectedImages[index].path);
                          if (userController.selectedImages[index].type ==
                              "video") {
                            imageFile = userController
                                        .selectedImages[index].thumbnail !=
                                    null
                                ? File(userController
                                    .selectedImages[index].thumbnail!)
                                : null;
                          }
                          return imageFile != null
                              ? InkWell(
                                  onTap: userController
                                              .selectedImages[index].type ==
                                          "video"
                                      ? () {}
                                      : null,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.file(imageFile),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: ClipOval(
                                                    child: Material(
                                                      color: const Color(
                                                              0xff261C2C)
                                                          .withOpacity(0.5),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.white,
                                                        onTap: () {
                                                          setState(() {
                                                            userController
                                                                .selectedImages
                                                                .removeAt(
                                                                    index);
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
                                      ),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${index + 1}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: s3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
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
                      userController.selectedImages.length != 2
                          ? InkWell(
                              onTap: () {
                                getImage();
                              },
                              child: Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  color: const Color(0xffE3E8FF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Feather.camera,
                                      color: Colors.black38,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Select Image",
                                      style: TextStyle(
                                        fontSize: s2,
                                        letterSpacing: 0.8,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
