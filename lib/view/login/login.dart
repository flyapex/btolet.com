import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:btolet/api/google_api.dart';
import 'package:btolet/controller/db_controller.dart';
import 'package:btolet/controller/widget/notification.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/api.dart';
import 'package:btolet/view/login/widget/permission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late VideoPlayerController _controller;
  UserController userController = Get.put(UserController());
  final DBController dbController = Get.find();

  @override
  void initState() {
    // getNofi();
    super.initState();
    _controller = VideoPlayerController.asset("assets/video/1.mp4")
      ..initialize().then((value) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  getNofi() async {
    await FirebaseMessagingService.initializeFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Column(
                      children: [
                        const Text(
                          "Best Way to",
                          style: TextStyle(
                            fontFamily: 'h2',
                            fontSize: 32.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                          child: AnimatedTextKit(
                            pause: const Duration(milliseconds: 1400),
                            repeatForever: true,
                            animatedTexts: [
                              TyperAnimatedText(
                                'find your stay 😊',
                                speed: const Duration(milliseconds: 150),
                              ),
                              TyperAnimatedText(
                                'save your time 🕒',
                                speed: const Duration(milliseconds: 150),
                              ),
                              TyperAnimatedText(
                                'save money 🤑',
                                speed: const Duration(milliseconds: 150),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        "By continuing,you aggree to our ",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (() {}),
                            child: const Text(
                              "User Agreement and  Privacy Policy.",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          var user = await GoogleSignInApi.login();

                          var userdetails = await userController.userLogin(
                            Newuser(
                              name: user!.displayName!,
                              email: user.email,
                              image: user.photoUrl ?? "",
                              geolocation: userController.geolocation.value,
                              signature: userController.signature.value,
                            ),
                          );

                          if (userdetails == false) {
                            Get.snackbar(
                              'ERROR👏🤝',
                              'We Will back soon',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.white,
                              borderRadius: 10,
                              margin: const EdgeInsets.all(10),
                            );
                          } else {
                            dbController.saveUserId(userdetails.uid);
                            Get.offAll(
                              () => const Permission(),
                              transition: Transition.circularReveal,
                              duration: const Duration(milliseconds: 600),
                            );

                            Get.snackbar(
                              'Congrats👏🤝',
                              'Welcome ${userdetails.name}',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.white,
                              borderRadius: 10,
                              margin: const EdgeInsets.all(10),
                            );
                          }
                        },
                        child: const SocialIcons(
                          icon: 'assets/icons/home/google.svg',
                          iconsize: 32,
                          title: "Sign up with Google     ",
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () async {
                          Get.snackbar(
                            '',
                            '',
                            snackPosition: SnackPosition.BOTTOM,
                            borderRadius: 6,
                            margin: const EdgeInsets.only(
                              top: 30,
                              right: 30,
                              left: 30,
                              bottom: 10,
                            ),
                            titleText: const Text('Under Deverlopment 👀👀 '),
                            messageText: const Text('Maybe Google? 👌'),
                            barBlur: 30,
                          );
                        },
                        child: const SocialIcons(
                          icon: 'assets/icons/home/fb.svg',
                          iconsize: 30,
                          title: "Sign up with Facebook",
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          // Get.offAll(
                          //   () => const Permission(),
                          //   transition: Transition.circularReveal,
                          //   duration: const Duration(milliseconds: 600),
                          // );

                          // Get.snackbar(
                          //   'Congrats👏🤝',
                          //   'Welcome ',
                          //   snackPosition: SnackPosition.TOP,
                          //   backgroundColor: Colors.white,
                          //   borderRadius: 10,
                          //   margin: const EdgeInsets.all(10),
                          // );
                          Get.snackbar(
                            '',
                            '',
                            snackPosition: SnackPosition.BOTTOM,
                            borderRadius: 6,
                            margin: const EdgeInsets.only(
                              top: 30,
                              right: 30,
                              left: 30,
                              bottom: 10,
                            ),
                            titleText: const Text('Under Deverlopment 👀👀 '),
                            messageText: const Text('Maybe Google? 👌'),
                            barBlur: 30,
                          );
                        },
                        child: const SocialIcons(
                          iconsize: 32,
                          icon: 'assets/icons/home/wapp.svg',
                          title: "Sign up with Whatsapp",
                        ),
                      ),
                      // const SizedBox(height: 50),
                      const SizedBox(height: 50),
                      const SizedBox(height: 50),
                      const SizedBox(height: 50),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SocialIcons extends StatelessWidget {
  final String icon;
  final String title;
  final double iconsize;

  const SocialIcons({
    Key? key,
    required this.icon,
    required this.title,
    required this.iconsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 35,
            width: 35,
            color: Colors.transparent,
            child: Center(
              child: SvgPicture.asset(
                icon,
                height: iconsize,
                width: iconsize,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontFamily: 'h3',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
