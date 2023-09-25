import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToletPage extends StatelessWidget {
  const ToletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
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
            Scrollbar(
              radius: const Radius.circular(20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 50,
                itemBuilder: (context, i) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Posts(),
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
        height: height / 6,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black12, spreadRadius: 1.1),
          ],
        ),
        child: Row(
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
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    width: width / 2.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
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
                                  fontSize: 16,
                                  color: Color(0xff083437),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.favorite_border_outlined,
                          color: Color(0xff083437),
                          size: 26,
                        )
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
                  SizedBox(
                    height: 20,
                    width: width / 2.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Khulna, Nirala",
                          style: TextStyle(
                            color: const Color(0xff083437).withOpacity(0.3),
                          ),
                        ),
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
              ),
            )
          ],
        ));
  }
}
