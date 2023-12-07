import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/model/postmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class SelectableChipsTypeSort extends StatefulWidget {
  final List categorylist;

  const SelectableChipsTypeSort({
    super.key,
    required this.categorylist,
  });

  @override
  State<SelectableChipsTypeSort> createState() =>
      _SelectableChipsTypeSortState();
}

class _SelectableChipsTypeSortState extends State<SelectableChipsTypeSort> {
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
    if (widget.catagoryName == area) {
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
      if (widget.catagoryName == area) {
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
                            if (widget.catagoryName == area) {
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
