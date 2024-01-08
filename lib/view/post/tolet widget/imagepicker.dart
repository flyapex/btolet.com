import 'dart:io';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

class ImagePicker extends StatefulWidget {
  final IconData icon;

  final int imagnumber;
  const ImagePicker({
    required this.icon,
    Key? key,
    required this.imagnumber,
  }) : super(key: key);

  @override
  ImagePickerState createState() => ImagePickerState();
}

class ImagePickerState extends State<ImagePicker> {
  ToletController toletController = Get.find();

  final _picker = HLImagePickerAndroid();

  Future<void> getImage() async {
    try {
      final images = await _picker.openPicker(
        cropping: false,
        selectedIds: toletController.selectedImages.map((e) => e.id).toList(),
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
        toletController.selectedImages = images;
        toletController.selectedImages;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        toletController.selectedImages.isEmpty
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
                          toletController.activeFlag.value
                              ? toletController.imageFlag.value
                                  ? const Color(0xff7F6BFC)
                                  : Colors.red
                              : const Color(0xff7F6BFC),
                        ),
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
                        itemCount: toletController.selectedImages.length,
                        itemBuilder: (_, index) {
                          File? imageFile =
                              File(toletController.selectedImages[index].path);
                          if (toletController.selectedImages[index].type ==
                              "video") {
                            imageFile = toletController
                                        .selectedImages[index].thumbnail !=
                                    null
                                ? File(toletController
                                    .selectedImages[index].thumbnail!)
                                : null;
                          }
                          return imageFile != null
                              ? InkWell(
                                  onTap: toletController
                                              .selectedImages[index].type ==
                                          "video"
                                      ? () {}
                                      : null,
                                  child: Stack(
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
                                                            toletController
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
                      toletController.selectedImages.length != 12
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
