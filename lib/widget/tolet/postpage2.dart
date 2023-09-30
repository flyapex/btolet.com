import 'package:flutter/material.dart';

class PostPage2 extends StatefulWidget {
  const PostPage2({super.key});

  @override
  State<PostPage2> createState() => _PostPage2State();
}

class _PostPage2State extends State<PostPage2> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Text Here',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
