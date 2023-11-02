import 'package:btolet/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class Myads extends StatefulWidget {
  const Myads({super.key});

  @override
  State<Myads> createState() => _MyadsState();
}

class _MyadsState extends State<Myads>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  UserController userController = Get.find();
  @override
  void initState() {
    userController.tabControllerDrawer = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ads'),
        centerTitle: false,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Feather.chevron_left),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0),
              insets: EdgeInsets.symmetric(horizontal: 30),
            ),
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.green,
            tabs: const [
              Tab(
                text: 'Running',
                // icon: Icon(Icons.account_circle_outlined),
              ),
              Tab(
                text: 'History',
                // icon: Icon(Icons.account_circle_outlined),
              ),
            ],
            controller: userController.tabControllerDrawer,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              controller: userController.tabControllerDrawer,
              children: const [
                MyAdsPage(),
                History(),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MyAdsPage extends StatelessWidget {
  const MyAdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          TextInputBoxAds(
            topPadding: 20,
            title: "Ads URL",
            textType: TextInputType.text,
            hintText: userController.adsUrl.value,
            suffixtext: "🔗",
            controller: userController.adsUrlTxtController,
            iconh: 23,
            iconw: 23,
          ),
        ],
      ),
    ));
  }
}

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(
        'Page Here',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}

class TextInputBoxAds extends StatefulWidget {
  final String title;
  final String hintText;
  final String suffixtext;
  final TextInputType textType;
  final double topPadding;
  final TextEditingController controller;
  final double iconh;
  final double iconw;

  const TextInputBoxAds({
    super.key,
    required this.title,
    required this.hintText,
    required this.suffixtext,
    required this.textType,
    required this.topPadding,
    required this.controller,
    required this.iconh,
    required this.iconw,
  });

  @override
  State<TextInputBoxAds> createState() => _TextInputBoxAdsState();
}

class _TextInputBoxAdsState extends State<TextInputBoxAds> {
  UserController userController = Get.find();
  var textstyle = TextStyle(
    overflow: TextOverflow.ellipsis,
    color: Colors.black.withOpacity(0.5),
    height: 1.2,
    fontSize: 16,
    letterSpacing: 1.2,
  );
  var textstyleh = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: 15,
    letterSpacing: 1.2,
    color: Colors.black.withOpacity(0.5),
  );
  var iconColorChange = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.topPadding),
        Text(
          widget.title,
          style: TextStyle(
            letterSpacing: 0.7,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffF2F3F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black.withOpacity(0.04)),
          ),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: Focus(
                    onFocusChange: (val) {
                      setState(() {
                        val ? iconColorChange = true : iconColorChange = false;
                      });
                    },
                    child: TextField(
                      // maxLength: widget.titlelenth,
                      cursorHeight: 24,
                      cursorWidth: 1.8,
                      cursorRadius: const Radius.circular(10),
                      controller: widget.controller,
                      textInputAction: TextInputAction.next,
                      keyboardType: widget.textType,
                      maxLines: 1,
                      cursorColor: Colors.black,
                      style: textstyle,
                      decoration: InputDecoration(
                        suffix: Text(
                          widget.suffixtext,
                          style: TextStyle(
                            color: iconColorChange
                                ? const Color(0xff0166EE)
                                : Colors.amber,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                        hintText: widget.hintText,
                        hintStyle: textstyleh,
                      ),
                      onChanged: (val) {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
