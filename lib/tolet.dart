import 'dart:ui';
import 'package:btolet/toletpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:marquee/marquee.dart';

class ToletHome extends StatelessWidget {
  const ToletHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Note(),
            const SizedBox(height: 20),
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1916&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: ' 11,983 ads in ',
                    style: TextStyle(
                        fontSize: 16, color: Colors.black.withOpacity(0.8)),
                    children: const [
                      TextSpan(
                        text: 'Khulna',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black.withOpacity(0.3)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Feather.sliders,
                              color: Colors.black45,
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text('Filter'),
                          ],
                        ),
                        Icon(Feather.chevron_down),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Scrollbar(
              radius: const Radius.circular(20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 50,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => const ToletPage(),
                        transition: Transition.circularReveal,
                        duration: const Duration(milliseconds: 600),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Posts(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Posts extends StatelessWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Container(
        height: height / 7,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black12, spreadRadius: 1.1),
          ],
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width / 2.8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1501183638710-841dd1904471?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1501183638710-841dd1904471?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 8,
                  color: Colors.yellowAccent,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.flash_on,
                              size: 14,
                            ),
                            Text(
                              "FEATURED",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff083437),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "৳ 2000",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xff083437),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "2 Bds -2 Ba -1234 ft2",
                        style: TextStyle(
                          color: Color(0xff083437),
                        ),
                      ),
                      Text(
                        "House For Rent",
                        style: TextStyle(
                          color: const Color(0xff083437).withOpacity(0.3),
                        ),
                      ),
                      Text(
                        "Khulna Nirala",
                        style: TextStyle(
                          color: const Color(0xff083437).withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // const Icon(
                  //   Icons.favorite_border_outlined,
                  //   color: Color(0xff083437),
                  //   size: 26,
                  // ),
                  LikeButton(
                    size: 26,
                    mainAxisAlignment: MainAxisAlignment.end,
                    circleColor: const CircleColor(
                      start: Color(0xff00ddff),
                      end: Color(0xff0099cc),
                    ),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    // likeCount: 665,
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        isLiked
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                      );
                    },
                    animationDuration: const Duration(milliseconds: 400),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "1 day ago",
                    style: TextStyle(
                      color: const Color(0xff083437).withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class Note extends StatelessWidget {
  const Note({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
          child: Marquee(
            text: "hello world! from btolet.com",
            // style: const TextStyle(
            //   fontWeight: FontWeight.bold,
            //   color: Colors.white,
            // ),
            scrollAxis: Axis.horizontal,
            // crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 100.0,
            velocity: 100.0,
            pauseAfterRound: const Duration(seconds: 1),
            // startPadding: 10.0,
            accelerationDuration: const Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: const Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
      ),
    );
  }
}
