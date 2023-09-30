import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NumberBox extends StatefulWidget {
  final String title;
  final String icon;
  final Color color;
  final String hintText;
  final TextInputType textType;
  final double topPadding;
  final double bottomPadding;
  final TextEditingController controller;
  final double iconh;
  final double iconw;
  const NumberBox({
    required this.title,
    required this.icon,
    required this.textType,
    required this.hintText,
    this.topPadding = 10,
    required this.controller,
    required this.iconh,
    required this.iconw,
    this.bottomPadding = 15,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<NumberBox> createState() => _NumberBoxState();
}

class _NumberBoxState extends State<NumberBox> {
  var hinttex = '017xxxxxxxx';
  var iconColorChange = false;
  var textstyle = const TextStyle(
    overflow: TextOverflow.fade,
    //! color: TextColors.maintextColor,
    height: 1.2,
    fontSize: 16,
    letterSpacing: 1.2,
  );
  var textstyleh = const TextStyle(
    overflow: TextOverflow.fade,
    height: 1.2,
    //! color: TextColors.hinttextColor,
    fontSize: 15,
    letterSpacing: 1.2,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.topPadding),
        Text(
          widget.title,
          style: const TextStyle(
            //! color: TextColors.taitletextColor,
            letterSpacing: 0.7,
          ),
        ),
        SizedBox(height: widget.bottomPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 48,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: const Color(0xffF2F3F5),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white),
                ),
                child: Stack(
                  children: [
                    widget.hintText == ''
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                hinttex,
                                style: textstyleh,
                              ),
                            ),
                          )
                        : Container(),
                    Focus(
                      onFocusChange: (v) {
                        widget.hintText == ''
                            ? setState(() {
                                hinttex = '';
                              })
                            : Container();
                      },
                      child: TextField(
                        autofillHints: const [
                          AutofillHints.telephoneNumber,
                        ],
                        cursorHeight: 22,
                        cursorWidth: 1.8,
                        cursorRadius: const Radius.circular(10),
                        controller: widget.controller,
                        textInputAction: TextInputAction.next,
                        keyboardType: widget.textType,
                        maxLines: 1,
                        cursorColor: Colors.black,
                        style: textstyle,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          isDense: true,
                          hintText: widget.hintText,
                          hintStyle: textstyleh,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // ignore: avoid_print
                // print('wapp');
              },
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(6),
                  // border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    widget.icon,
                    height: widget.iconh,
                    width: widget.iconw,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
