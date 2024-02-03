import 'dart:io';
import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

class ImagePickerProFloorPlan extends StatefulWidget {
  final IconData icon;
  final int imagnumber;
  final Color color;
  const ImagePickerProFloorPlan({
    required this.icon,
    Key? key,
    required this.imagnumber,
    required this.color,
  }) : super(key: key);

  @override
  ImagePickerProFloorPlanState createState() => ImagePickerProFloorPlanState();
}

class ImagePickerProFloorPlanState extends State<ImagePickerProFloorPlan> {
  ProController proController = Get.find();

  final _picker = HLImagePickerAndroid();

  Future<void> getImage() async {
    try {
      final images = await _picker.openPicker(
        cropping: false,
        selectedIds:
            proController.selectedImageProFloorplan.map((e) => e.id).toList(),
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
        proController.selectedImageProFloorplan = images;
        proController.selectedImageProFloorplan;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        proController.selectedImageProFloorplan.isEmpty
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
                          widget.color,
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
                                fontSize: s3,
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
                            proController.selectedImageProFloorplan.length,
                        itemBuilder: (_, index) {
                          File? imageFile = File(proController
                              .selectedImageProFloorplan[index].path);
                          if (proController
                                  .selectedImageProFloorplan[index].type ==
                              "video") {
                            imageFile = proController
                                        .selectedImageProFloorplan[index]
                                        .thumbnail !=
                                    null
                                ? File(proController
                                    .selectedImageProFloorplan[index]
                                    .thumbnail!)
                                : null;
                          }
                          return imageFile != null
                              ? InkWell(
                                  onTap: proController
                                              .selectedImageProFloorplan[index]
                                              .type ==
                                          "video"
                                      ? () {}
                                      : null,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.file(imageFile),
                                      ),
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
                                                        proController
                                                            .selectedImageProFloorplan
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
                      proController.selectedImageProFloorplan.length != 1
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
                                        widget.color,
                                      ),
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
                                              fontSize: s3,
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

class ImagePickerPro extends StatefulWidget {
  final IconData icon;
  final int imagnumber;
  final Color color;
  const ImagePickerPro({
    required this.icon,
    Key? key,
    required this.imagnumber,
    required this.color,
  }) : super(key: key);

  @override
  ImagePickerProState createState() => ImagePickerProState();
}

class ImagePickerProState extends State<ImagePickerPro> {
  ProController proController = Get.find();

  final _picker = HLImagePickerAndroid();

  Future<void> getImage() async {
    try {
      final images = await _picker.openPicker(
        cropping: false,
        selectedIds: proController.selectedImagePro.map((e) => e.id).toList(),
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
        proController.selectedImagePro = images;
        proController.selectedImagePro;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        proController.selectedImagePro.isEmpty
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
                          proController.activeFlag.value
                              ? proController.imageFlag.value
                                  ? widget.color
                                  : Colors.red
                              : widget.color,
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
                                fontSize: s3,
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
                        itemCount: proController.selectedImagePro.length,
                        itemBuilder: (_, index) {
                          File? imageFile =
                              File(proController.selectedImagePro[index].path);
                          if (proController.selectedImagePro[index].type ==
                              "video") {
                            imageFile = proController
                                        .selectedImagePro[index].thumbnail !=
                                    null
                                ? File(proController
                                    .selectedImagePro[index].thumbnail!)
                                : null;
                          }
                          return imageFile != null
                              ? InkWell(
                                  onTap: proController
                                              .selectedImagePro[index].type ==
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
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
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
                                                              proController
                                                                  .selectedImagePro
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          },
                                                          child: SizedBox(
                                                            width: 27,
                                                            height: 27,
                                                            child: Icon(
                                                              Feather.x,
                                                              color: Colors
                                                                  .white
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
                      proController.selectedImagePro.length != 12
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
                                        widget.color,
                                      ),
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
                                              fontSize: s3,
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
