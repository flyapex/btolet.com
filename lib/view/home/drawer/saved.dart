import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import 'saved/pro.dart';
import 'saved/tolet.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ToletController toletController = Get.find();
  @override
  void initState() {
    toletController.tabControllerDrawer = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Post',
          style: TextStyle(
            fontSize: s1,
            height: 0.5,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7),
            // fontFamily: 'Roboto',
          ),
        ),
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
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  'Rent',
                  style: TextStyle(
                    fontSize: s3,
                    height: 0.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),

                // icon: Icon(Icons.account_circle_outlined),
              ),
              Tab(
                child: Text(
                  'Buy',
                  style: TextStyle(
                    fontSize: s3,
                    height: 0.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),

                // icon: Icon(Icons.account_circle_outlined),
              ),
            ],
            controller: toletController.tabControllerDrawer,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              controller: toletController.tabControllerDrawer,
              children: const [
                SavedToletPage(),
                // PropertyHomeTEMP()
                SavedProPage(),
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

//*--------------------------------element
