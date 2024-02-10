import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/tolet_model.dart';
import 'package:btolet/view/tolet/single_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';

class CategoryBodyPost extends StatelessWidget {
  final SingleToletPostModel postData;
  const CategoryBodyPost({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    mainBody() {
      var catagory = postData.category;
      // print(catagory);
      if (catagory.contains('Only Garage')) {
        if (postData.garagetype == "Garage") {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
                width: 25,
                child: SvgPicture.asset(
                  'assets/icons/tolet/garage.svg',
                  colorFilter: ColorFilter.mode(
                    // Color(0xff083437),
                    const Color(0xff083437).withOpacity(0.5),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  postData.garagetype,
                  style: const TextStyle(
                    color: Color(0xff083437),
                    fontWeight: FontWeight.bold,
                    fontSize: s3,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              SizedBox(
                height: 10,
                width: 10,
                child: SvgPicture.asset(
                  'assets/icons/tolet/security.svg',
                  colorFilter: const ColorFilter.mode(
                    // Color(0xff083437),
                    Colors.green,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          );
        } else if (postData.garagetype == "Bike") {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.asset(
                  'assets/icons/tolet/bike.svg',
                  colorFilter: ColorFilter.mode(
                    // Color(0xff083437),
                    const Color(0xff083437).withOpacity(0.5),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "${postData.garagetype} Garage",
                style: const TextStyle(
                  color: Color(0xff083437),
                  fontWeight: FontWeight.bold,
                  fontSize: s3,
                  height: 1,
                ),
              ),
              const SizedBox(width: 3),
              SizedBox(
                height: 10,
                width: 10,
                child: SvgPicture.asset(
                  'assets/icons/tolet/security.svg',
                  colorFilter: const ColorFilter.mode(
                    // Color(0xff083437),
                    Colors.green,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.asset(
                  'assets/icons/tolet/car.svg',
                  colorFilter: ColorFilter.mode(
                    // Color(0xff083437),
                    const Color(0xff083437).withOpacity(0.5),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "${postData.garagetype} Garage",
                style: const TextStyle(
                  color: Color(0xff083437),
                  fontWeight: FontWeight.bold,
                  fontSize: s3,
                  height: 1,
                ),
              ),
              const SizedBox(width: 3),
              SizedBox(
                height: 10,
                width: 10,
                child: SvgPicture.asset(
                  'assets/icons/tolet/security.svg',
                  colorFilter: const ColorFilter.mode(
                    // Color(0xff083437),
                    Colors.green,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          );
        }
      } else if (catagory.contains('Office')) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              postData.category.join(', '),
              style: TextStyle(
                color: const Color(0xff083437).withOpacity(0.5),
                fontWeight: FontWeight.bold,
                fontSize: s1,
                height: 0.5,
              ),
            ),
          ],
        );
      } else if (catagory.contains('Shop')) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              postData.category.join(', '),
              style: TextStyle(
                color: const Color(0xff083437).withOpacity(0.5),
                fontWeight: FontWeight.bold,
                fontSize: s1,
                height: 0.5,
              ),
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 28,
                    width: 28,
                    child: SvgPicture.asset(
                      'assets/icons/tolet/bed.svg',
                      colorFilter: ColorFilter.mode(
                        const Color(0xff083437).withOpacity(0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      '${postData.bed} Beds',
                      style: const TextStyle(
                        color: Color(0xff083437),
                        fontWeight: FontWeight.bold,
                        fontSize: s3,
                        height: 1,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 28,
                    width: 28,
                    child: SvgPicture.asset(
                      'assets/icons/tolet/bath.svg',
                      colorFilter: ColorFilter.mode(
                        const Color(0xff083437).withOpacity(0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      '${postData.bath} Baths',
                      style: const TextStyle(
                        color: Color(0xff083437),
                        fontWeight: FontWeight.bold,
                        fontSize: s3,
                        height: 1,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: postData.roomsize == ''
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: SvgPicture.asset(
                            'assets/icons/tolet/kitchen.svg',
                            colorFilter: ColorFilter.mode(
                              const Color(0xff083437).withOpacity(0.5),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            "  ${postData.kitchen} Kitchen",
                            style: const TextStyle(
                              color: Color(0xff083437),
                              fontWeight: FontWeight.bold,
                              fontSize: s3,
                              height: 1,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/icons/tolet/size.svg',
                            colorFilter: ColorFilter.mode(
                              const Color(0xff083437).withOpacity(0.5),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            "  ${postData.roomsize} ft\u00b2",
                            style: const TextStyle(
                              color: Color(0xff083437),
                              fontWeight: FontWeight.bold,
                              fontSize: s3,
                              height: 1,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        );
      }
    }

    mainBody2() {
      var catagory = postData.category.join(', ');

      // print(catagory);
      if (catagory.contains('Only Garage')) {
        return Column(
          children: [
            Details(
              type: "Property Name",
              detailstext: postData.propertyname,
              icon: Icons.home_outlined,
            ),
            Details(
              type: "Property Type",
              detailstext: postData.category.join(', '),
              icon: Icons.business_outlined,
            ),
            Details(
              type: "Rent From",
              detailstext: DateFormat('d MMM').format(postData.rentfrom),
              icon: Icons.access_time,
            ),
            Details(
              type: "Short Address",
              detailstext: postData.shortaddress,
              icon: Icons.share_location_rounded,
            ),
          ],
        );
      } else if (catagory.contains('Office')) {
        return Column(
          children: [
            Details(
              type: "Property Name",
              detailstext: postData.propertyname,
              icon: Icons.home_outlined,
            ),
            Details(
              type: "Property Type",
              detailstext: postData.category.join(', '),
              icon: Icons.business_outlined,
            ),
            Details(
              type: "Room",
              detailstext: postData.bed,
              icon: Icons.cottage_outlined,
            ),
            Details(
              type: "Wash Room",
              detailstext: postData.bath,
              icon: Icons.shower_outlined,
            ),
            Details(
              type: "Floor",
              detailstext: postData.floornumber,
              icon: Icons.person_pin_circle_outlined,
            ),
            Details(
              type: "Size",
              detailstext: postData.roomsize,
              icon: Icons.window_outlined,
            ),
            Details(
              type: "Rent From",
              detailstext: DateFormat('d MMM').format(postData.rentfrom),
              icon: Icons.access_time,
            ),
            Details(
              type: "Facilities",
              detailstext: postData.fasalitis.isEmpty
                  ? ""
                  : postData.fasalitis.join(", "),
              icon: Icons.search_sharp,
              textColor: Colors.green,
            ),
            Details(
              type: "Maintenance",
              detailstext: postData.mentenance == 0
                  ? ""
                  : "${NumberFormat.decimalPattern().format(postData.mentenance)} tk/mon",
              icon: Icons.monetization_on_outlined,
            ),
            Details(
              type: "Short Address",
              detailstext: postData.shortaddress,
              icon: Icons.share_location_rounded,
            ),
          ],
        );
      } else if (catagory.contains('Shop')) {
        return Column(
          children: [
            Details(
              type: "Floor Number",
              detailstext: postData.floornumber,
              icon: Icons.person_pin_circle_outlined,
            ),
            Details(
              type: "Facing",
              detailstext: postData.facing,
              icon: Icons.window_outlined,
            ),
            Details(
              type: "Size",
              detailstext: postData.roomsize,
              icon: Icons.window_outlined,
            ),
            Details(
              type: "Facing",
              detailstext: postData.facing,
              icon: Icons.window_outlined,
            ),
            Details(
              type: "Rent From",
              detailstext: DateFormat('d MMM').format(postData.rentfrom),
              icon: Icons.access_time,
            ),
            Details(
              type: "Facilities",
              detailstext: postData.fasalitis.isEmpty
                  ? ""
                  : postData.fasalitis.join(", "),
              icon: Icons.search_sharp,
              textColor: Colors.green,
            ),
            Details(
              type: "Maintenance",
              detailstext: postData.mentenance == 0
                  ? ""
                  : "${NumberFormat.decimalPattern().format(postData.mentenance)} tk/mon",
              icon: Icons.monetization_on_outlined,
            ),
            Details(
              type: "Short Address",
              detailstext: postData.shortaddress,
              icon: Icons.share_location_rounded,
            ),
          ],
        );
      } else {
        return Column(
          children: [
            Details(
              type: "Property Name",
              detailstext: postData.propertyname,
              icon: Icons.home_outlined,
            ),
            Details(
              type: "Property Type",
              detailstext: postData.category.join(', '),
              icon: Icons.business_outlined,
            ),
            Details(
              type: "Dining",
              detailstext: postData.dining,
              icon: Icons.dining_outlined,
            ),
            Details(
              type: "Drawing",
              detailstext: postData.drawing,
              icon: Icons.chair_outlined,
            ),
            Details(
              type: "Kitchen",
              detailstext: postData.kitchen,
              icon: Icons.kitchen_rounded,
            ),
            Details(
              type: "Balcony",
              detailstext: postData.balcony,
              icon: Icons.balcony_outlined,
            ),
            Details(
              type: "Floor",
              detailstext: postData.floornumber,
              icon: Icons.person_pin_circle_outlined,
            ),
            Details(
              type: "Facing",
              detailstext: postData.facing,
              icon: Icons.window_outlined,
            ),
            Details(
              type: "Rent From",
              detailstext: DateFormat('d MMM').format(postData.rentfrom),
              icon: Icons.access_time,
            ),
            Details(
              type: "Facilities",
              detailstext: postData.fasalitis.isEmpty
                  ? ""
                  : postData.fasalitis.join(", "),
              icon: Icons.search_sharp,
              textColor: Colors.green,
            ),
            Details(
              type: "Maintenance",
              detailstext: postData.mentenance == 0
                  ? ""
                  : "${NumberFormat.decimalPattern().format(postData.mentenance)} tk/mon",
              icon: Icons.monetization_on_outlined,
            ),
            Details(
              type: "Short Address",
              detailstext: postData.shortaddress,
              icon: Icons.share_location_rounded,
            ),
          ],
        );
      }
    }

    UserController userController = Get.find();

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "৳ ",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff083437),
                  ),
                ),
                Text(
                  NumberFormat.decimalPattern().format(postData.rent),
                  style: const TextStyle(
                    fontSize: 35,
                    color: Color(0xff083437),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            mainBody(),
          ],
        ).paddingAll(20),
        Column(
          children: [
            Container(
              height: 1,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
            ).paddingOnly(left: 20, right: 20),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final coords = Coords(
                        double.parse(postData.geolat),
                        double.parse(postData.geolon),
                      );
                      var title =
                          "Price ৳ ${NumberFormat.decimalPattern().format(postData.rent)}";
                      final availableMaps = await MapLauncher.installedMaps;
                      await availableMaps.first.showMarker(
                        coords: coords,
                        title: title,
                        description: "description",
                      );
                    },
                    child: Row(
                      children: [
                        Material(
                          type: MaterialType.transparency,
                          child: Ink(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              ),
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: SvgPicture.asset(
                                    'assets/icons/home/map.svg',
                                    height: 10,
                                    width: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            postData.location,
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xff083437).withOpacity(0.7),
                              // fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: 'Roboto',
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '${userController.getDay(postData.time)}',
                  style: const TextStyle(
                    fontSize: s5,
                    color: Color(0xff083437),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ).paddingOnly(left: 20, right: 20)
          ],
        ),
        Container(
          height: 20,
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            color: Colors.black12,
          ),
        ),
        Container(
          height: 1,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Details",
                  style: TextStyle(
                    fontSize: s3,
                    color: Color(0xff083437),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "id:${postData.postId}",
                  style: TextStyle(
                    fontSize: s4,
                    color: const Color(0xff083437).withOpacity(0.7),
                  ),
                ),
              ],
            ),
            mainBody2(),
            const SizedBox(height: 20),
            Container(
              height: 1,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Feather.menu,
                  color: const Color(0xff8595A9).withOpacity(0.5),
                  size: 18,
                ),
                const SizedBox(width: 10),
                Text(
                  "Discription",
                  style: h3,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffE3E8FF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 15,
                  bottom: 20,
                ),
                child: Text(
                  postData.description,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.clip,
                  style: h3,
                  // maxLines: 5,
                ),
              ),
            ),
          ],
        ).paddingOnly(left: 20, right: 20)
      ],
    );
  }
}
