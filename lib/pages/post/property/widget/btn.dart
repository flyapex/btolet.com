import 'dart:io';

import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/model/postmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

class SelectableChipsType extends StatefulWidget {
  final List categorylist;

  const SelectableChipsType({
    super.key,
    required this.categorylist,
  });

  @override
  State<SelectableChipsType> createState() => _SelectableChipsTypeState();
}

class _SelectableChipsTypeState extends State<SelectableChipsType> {
  int selectedChoiceIndex = 0;

  _buildChoiceChips() {
    return widget.categorylist.map<Widget>((dynamic option) {
      return ChoiceChip(
        label: Text(option),
        selected: selectedChoiceIndex == widget.categorylist.indexOf(option),
        onSelected: (bool selected) {
          setState(() {
            selectedChoiceIndex =
                selected ? widget.categorylist.indexOf(option) : -1;
          });
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Wrap(
            spacing: 8.0,
            children: _buildChoiceChips(),
          ),
        ],
      ),
    );
  }
}

class AreaBox extends StatefulWidget {
  final String title;
  final double topPadding;
  final List catagoryName;
  final double widthh;
  const AreaBox({
    super.key,
    required this.title,
    this.topPadding = 10.0,
    required this.catagoryName,
    required this.widthh,
  });

  @override
  State<AreaBox> createState() => _AreaBoxState();
}

class _AreaBoxState extends State<AreaBox> {
  final PostController postController = Get.find();

  var textstylemain = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: 15,
    letterSpacing: 1.2,
    color: Colors.black.withOpacity(0.7),
  );
  var textstyleh = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: 15,
    letterSpacing: 1.2,
    color: Colors.black.withOpacity(0.6),
  );

  getText() {
    if (widget.catagoryName == diningProperty) {
      return postController.diningProperty.value;
    } else if (widget.catagoryName == area) {
      return postController.area.value;
    }
    //  else if (widget.catagoryName == floors) {
    //   return postController.floors.value;
    // } else if (widget.catagoryName == facing) {
    //   return postController.facing.value;
    // } else if (widget.catagoryName == kitchen) {
    //   return postController.kitchen.value;
    // }
  }

  @override
  Widget build(BuildContext context) {
    getTextList() {
      if (widget.catagoryName == diningProperty) {
        return diningProperty;
      } else if (widget.catagoryName == area) {
        return area;
      }
      // else if (widget.catagoryName == floors) {
      //   return floors;
      // } else if (widget.catagoryName == facing) {
      //   return facing;
      // } else if (widget.catagoryName == kitchen) {
      //   return kitchen;
      // }
    }

    return Obx(
      (() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: widget.topPadding)),
            Text(
              widget.title,
              style: TextStyle(
                letterSpacing: 0.7,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffF2F3F5),
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 48,
                    width: (Get.width / 3),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          isExpanded: true,
                          icon: Icon(
                            Feather.chevron_down,
                            color: Colors.black.withOpacity(0.4),
                          ),
                          hint: Text(
                            getText(),
                            style: getText() == 'select'
                                ? textstyleh
                                : textstylemain,
                          ),
                          items: getTextList()?.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (widget.catagoryName == rooms) {
                              postController.diningProperty.value =
                                  val.toString();
                            } else if (widget.catagoryName == area) {
                              postController.area.value = val.toString();
                            }
                            // else if (widget.catagoryName == floors) {
                            //   postController.floors.value = val.toString();
                            // } else if (widget.catagoryName == facing) {
                            //   postController.facing.value = val.toString();
                            // } else if (widget.catagoryName == kitchen) {
                            //   postController.kitchen.value = val.toString();
                            // }
                            // postController.allCategoryCheck();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class DragdownBoxProperty extends StatefulWidget {
  final String title;
  final double topPadding;
  final List catagoryName;
  final double widthh;
  const DragdownBoxProperty({
    super.key,
    required this.title,
    this.topPadding = 10.0,
    required this.catagoryName,
    required this.widthh,
  });

  @override
  State<DragdownBoxProperty> createState() => _DragdownBoxPropertyState();
}

class _DragdownBoxPropertyState extends State<DragdownBoxProperty> {
  final PostController postController = Get.find();

  var textstylemain = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: 15,
    letterSpacing: 1.2,
    color: Colors.black.withOpacity(0.7),
  );
  var textstyleh = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: 15,
    letterSpacing: 1.2,
    color: Colors.black.withOpacity(0.6),
  );

  getText() {
    if (widget.catagoryName == diningProperty) {
      return postController.diningProperty.value;
    } else if (widget.catagoryName == area) {
      return postController.area.value;
    }
    //  else if (widget.catagoryName == floors) {
    //   return postController.floors.value;
    // } else if (widget.catagoryName == facing) {
    //   return postController.facing.value;
    // } else if (widget.catagoryName == kitchen) {
    //   return postController.kitchen.value;
    // }
  }

  @override
  Widget build(BuildContext context) {
    getTextList() {
      if (widget.catagoryName == diningProperty) {
        return diningProperty;
      } else if (widget.catagoryName == area) {
        return area;
      }
      // else if (widget.catagoryName == floors) {
      //   return floors;
      // } else if (widget.catagoryName == facing) {
      //   return facing;
      // } else if (widget.catagoryName == kitchen) {
      //   return kitchen;
      // }
    }

    return Obx(
      (() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: widget.topPadding)),
            Text(
              widget.title,
              style: TextStyle(
                letterSpacing: 0.7,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffF2F3F5),
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 48,
                    width: (Get.width / widget.widthh),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          isExpanded: true,
                          icon: Icon(
                            Feather.chevron_down,
                            color: Colors.black.withOpacity(0.4),
                          ),
                          hint: Text(
                            getText(),
                            style: getText() == 'select'
                                ? textstyleh
                                : textstylemain,
                          ),
                          items: getTextList()?.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (widget.catagoryName == rooms) {
                              postController.diningProperty.value =
                                  val.toString();
                            } else if (widget.catagoryName == area) {
                              postController.area.value = val.toString();
                            }
                            // else if (widget.catagoryName == floors) {
                            //   postController.floors.value = val.toString();
                            // } else if (widget.catagoryName == facing) {
                            //   postController.facing.value = val.toString();
                            // } else if (widget.catagoryName == kitchen) {
                            //   postController.kitchen.value = val.toString();
                            // }
                            // postController.allCategoryCheck();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CustomeChipPorperty extends StatelessWidget {
  final String text;

  final IconData icon;
  const CustomeChipPorperty({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.find();
    getController() {
      switch (text) {
        case "Balcony":
          return postController.pbalcony.value;
        case "Parking":
          return postController.pparking.value;
        case "CCTV":
          return postController.pcctv.value;
        case "GAS":
          return postController.pgas.value;
        case "Elevator":
          return postController.pelevator.value;
        case "Security Guard":
          return postController.psecurity.value;
        case "Power Backup":
          return postController.ppowerbackup.value;
        case "Fire Alarm":
          return postController.pfirealarm.value;
        case "Gaser":
          return postController.pgaser.value;
        case "Wasa Connection":
          return postController.wasaconnection.value;
        case "Fire exit":
          return postController.fireexit.value;
        case "West Disposal":
          return postController.westdisposal.value;
        case "Garden":
          return postController.garden.value;
        case "Electricity":
          return postController.electricity.value;
        case "Drain":
          return postController.drain.value;
        default:
          return false;
      }
    }

    return Obx(
      () => FilterChip(
        showCheckmark: false,
        label: Text(text),
        selected: getController(),
        onSelected: (value) {
          // postController.lift.value = !postController.lift.value;
          switch (text) {
            case "Balcony":
              postController.pbalcony.value = !postController.pbalcony.value;
              break;
            case "Parking":
              postController.pparking.value = !postController.pparking.value;
              break;
            case "CCTV":
              postController.pcctv.value = !postController.pcctv.value;
              break;
            case "GAS":
              postController.pgas.value = !postController.pgas.value;
              break;
            case "Lift":
              postController.pelevator.value = !postController.pelevator.value;
              break;
            case "Security Guard":
              postController.psecurity.value = !postController.psecurity.value;
              break;
            case "WIFI":
              postController.pwifi.value = !postController.pwifi.value;
              break;
            case "Power Backup":
              postController.ppowerbackup.value =
                  !postController.ppowerbackup.value;
              break;
            case "Fire Alarm":
              postController.pfirealarm.value =
                  !postController.pfirealarm.value;
              break;
            case "Gaser":
              postController.pgaser.value = !postController.pgaser.value;
              break;
            case "Wasa Connection":
              postController.wasaconnection.value =
                  !postController.wasaconnection.value;
              break;
            case "Fire exit":
              postController.fireexit.value = !postController.fireexit.value;
              break;
            case "West Disposal":
              postController.westdisposal.value =
                  !postController.westdisposal.value;
              break;

            case "Garden":
              postController.garden.value = !postController.garden.value;
              break;
            case "Electricity":
              postController.electricity.value =
                  !postController.electricity.value;
              break;
            case "Drain":
              postController.drain.value = !postController.drain.value;
              break;
            default:
              break;
          }
        },
        avatar: Icon(
          icon,
          // getController() ? Icons.check : icon,
          color: getController()
              ? const Color(0xff0166EE)
              : const Color.fromARGB(255, 192, 194, 198),
          // color: getController()
          //     ? const Color(0xff0166EE)
          //     : const Color.fromARGB(255, 192, 194, 198),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        side: BorderSide(
          color: getController()
              ? const Color(0xff0166EE)
              : Colors.black.withOpacity(0.1),
        ),
        elevation: 0.3,
        selectedShadowColor: Colors.black.withOpacity(0.5),
        shadowColor: Colors.black.withOpacity(0.5),
        backgroundColor: Colors.white,
        selectedColor: Colors.white,
      ),
    );
  }
}

class SelectImageProperty extends StatefulWidget {
  final IconData icon;

  final int imagnumber;
  final Color color;
  const SelectImageProperty({
    required this.icon,
    Key? key,
    required this.imagnumber,
    required this.color,
  }) : super(key: key);

  @override
  SelectImageState createState() => SelectImageState();
}

class SelectImageState extends State<SelectImageProperty> {
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
          enablePreview: false,
          // isExportThumbnail: _isExportThumbnail,
          thumbnailCompressFormat: CompressFormat.jpg,
          thumbnailCompressQuality: 0.9,
          recordVideoMaxSecond: 40,
          maxSelectedAssets: widget.imagnumber,
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
                        backgroundColor: MaterialStateProperty.all(
                          widget.color,
                          // const Color(0xff7F6BFC),
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
                                fontSize: 12,
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
                                  onTap: () {},
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
                      _selectedImages.length != 12
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
                                              fontSize: 12,
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

class SelectVideoProperty extends StatefulWidget {
  final IconData icon;

  final int videoNumber;
  final Color color;
  const SelectVideoProperty({
    required this.icon,
    Key? key,
    required this.videoNumber,
    required this.color,
  }) : super(key: key);

  @override
  SelectVideoPropertyState createState() => SelectVideoPropertyState();
}

class SelectVideoPropertyState extends State<SelectVideoProperty> {
  PostController postController = Get.find();

  final _picker = HLImagePickerAndroid();

  List<HLPickerItem> _selectedVideo = [];

  Future<void> getVideo() async {
    try {
      final images = await _picker.openPicker(
        cropping: false,
        // ignore: dead_code
        selectedIds: true ? _selectedVideo.map((e) => e.id).toList() : null,
        pickerOptions: HLPickerOptions(
          mediaType: MediaType.video,
          enablePreview: false,
          isExportThumbnail: true,
          thumbnailCompressFormat: CompressFormat.jpg,
          thumbnailCompressQuality: 0.9,
          recordVideoMaxSecond: 40,
          maxSelectedAssets: widget.videoNumber,
          usedCameraButton: true,
          numberOfColumn: 3,
        ),
      );
      setState(() {
        _selectedVideo = images;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _selectedVideo.isEmpty
            ? Row(
                children: [
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () async {
                        getVideo();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(widget.color),
                        // backgroundColor:
                        //     MaterialStateProperty.all(const Color(0xff7F6BFC)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              widget.icon,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "Select Video",
                              style: TextStyle(
                                fontSize: 12,
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
                        itemCount: _selectedVideo.length,
                        itemBuilder: (_, index) {
                          File? imageFile = File(_selectedVideo[index].path);
                          if (_selectedVideo[index].type == "video") {
                            imageFile = _selectedVideo[index].thumbnail != null
                                ? File(_selectedVideo[index].thumbnail!)
                                : null;
                          }
                          // ignore: unnecessary_null_comparison
                          return imageFile != null
                              ? InkWell(
                                  onTap: () {},
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
                                                        _selectedVideo
                                                            .removeAt(index);
                                                      });
                                                    },
                                                    child: SizedBox(
                                                      width: 27,
                                                      height: 27,
                                                      child: Icon(
                                                        Feather.x,
                                                        color: Colors.white
                                                            .withOpacity(0.9),
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
                                  child: const Text('No thumbnail'),
                                );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(width: 8.0),
                      ),
                      _selectedVideo.length != 2
                          ? Row(
                              children: [
                                SizedBox(
                                  height: 44,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      getVideo();
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
                                            "Select Video",
                                            style: TextStyle(
                                              fontSize: 12,
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
