import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Description extends StatefulWidget {
  final String title;
  final IconData icon;
  final String hintText;
  final TextInputType textType;
  final TextEditingController controller;
  final FocusNode focusNode;
  const Description(
      {Key? key,
      required this.title,
      required this.icon,
      required this.hintText,
      required this.textType,
      required this.controller,
      required this.focusNode})
      : super(key: key);

  @override
  DescriptionState createState() => DescriptionState();
}

class DescriptionState extends State<Description> {
  UserController userController = Get.find();
  var textstyle = const TextStyle(
    overflow: TextOverflow.fade,
    height: 1.2,
    // fontSize: s2,
    fontFamily: 'Roboto',
    fontSize: 14,
  );
  var textstyleh = TextStyle(
    overflow: TextOverflow.fade,
    height: 1.2,
    // fontSize: s2,
    // letterSpacing: 1.2,
    fontFamily: 'Roboto',
    fontSize: 14,
    color: Colors.black.withOpacity(0.3),
  );
  var iconColorChange = false;
  var focusNode = FocusNode();
  getFocus() {
    if (widget.focusNode == userController.descriptionfocusNode) {
      FocusScope.of(context).requestFocus(userController.phonefocusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            letterSpacing: 0.7,
            fontSize: s3,
          ),
        ),
        const SizedBox(height: 15),
        InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(focusNode);
          },
          child: Container(
            height: 170,
            width: Get.width,
            decoration: BoxDecoration(
              color: const Color(0xffF2F3F5),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    margin: const EdgeInsets.only(left: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      widget.icon,
                      color: iconColorChange
                          ? Colors.blueAccent
                          : Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Expanded(
                    child: Focus(
                      onFocusChange: (val) {
                        setState(() {
                          val
                              ? iconColorChange = true
                              : iconColorChange = false;
                        });
                      },
                      child: TextField(
                        // textAlignVertical: TextAlignVertical.top,
                        // textAlign: TextAlign.center,
                        focusNode: widget.focusNode,
                        cursorHeight: 28,
                        cursorWidth: 1.8,
                        cursorRadius: const Radius.circular(10),
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 100,
                        controller: widget.controller,
                        textInputAction: TextInputAction.newline,
                        cursorColor: Colors.black,
                        style: textstyle,

                        decoration: InputDecoration(
                          // contentPadding:
                          //     EdgeInsets.only(top: !iconColorChange ? 0 : 30),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          isDense: true,
                          hintText: iconColorChange ? '' : widget.hintText,
                          hintStyle: textstyleh,
                        ),
                        onChanged: (v) {},
                        onSubmitted: (v) {
                          getFocus();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NumberInput extends StatefulWidget {
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
  final FocusNode focusNode;
  final int numberLength;
  const NumberInput({
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
    required this.focusNode,
    required this.numberLength,
  }) : super(key: key);

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final UserController userController = Get.find();
  ProController proController = Get.find();
  ToletController toletController = Get.find();

  static const TextStyle textstyle = TextStyle(
    overflow: TextOverflow.fade,
    height: 1.2,
    fontSize: s3,
    letterSpacing: 1.2,
  );

  static const TextStyle textstyleh = TextStyle(
    overflow: TextOverflow.fade,
    height: 1.2,
    fontSize: s3,
    letterSpacing: 1.2,
  );

  var hinttex = '017xxxxxxxx';
  var iconColorChange = false;

  getBorderColor() {
    final phoneFlag = userController.phoneFlag.value;
    return toletController.activeFlag.value || proController.activeFlag.value
        ? phoneFlag
            ? Colors.white
            : Colors.red
        : Colors.white;
  }

  getFocus() {
    if (widget.focusNode == userController.phonefocusNode) {
      FocusScope.of(context).requestFocus(userController.wappfocusNode);
    }
  }

  Country _selectedCupertinoCountry =
      CountryPickerUtils.getCountryByIsoCode('BD');
  void _openCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          pickerSheetHeight: Get.height / 3,
          backgroundColor: const Color(0xff161A2D),
          itemBuilder: _buildCupertinoSelectedItemPopup,
          initialCountry: _selectedCupertinoCountry,
          onValuePicked: (Country country) {
            var code = country.phoneCode;

            if (code != null && code.isNotEmpty) {
              code = code.substring(0, code.length - 1);
            }
            userController.code.value = "+$code";
            print(userController.code.value);
            setState(
              () => _selectedCupertinoCountry = country,
            );
          },
        );
      });
  Widget _buildCupertinoSelectedItemPopup(Country country) {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: s4,
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 40),
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 10),
          Flexible(child: Text(country.isoCode ?? '')),
          const SizedBox(width: 10),
          Text(
            "+${country.phoneCode}",
            style: const TextStyle(
              fontSize: s4,
              height: 1.3,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildCupertinoSelectedItem(Country country) {
    var code = country.phoneCode;

    if (code != null && code.isNotEmpty) {
      code = code.substring(0, code.length - 1);
    }
    return Row(
      children: <Widget>[
        // CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(width: 8.0),

        // Text(
        //   '+$code',
        //   style: h3,
        // ),
        Text(
          "+${country.phoneCode}",
          style: h3,
        ),
        const SizedBox(width: 8.0),
        // Flexible(child: Text(country.name ?? ''))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.topPadding),
        Text(
          widget.title,
          style: const TextStyle(letterSpacing: 0.7, fontSize: s3),
        ),
        SizedBox(height: widget.bottomPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: _openCupertinoCountryPicker,
              child: Container(
                height: 48,
                width: 100,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: const Color(0xffF2F3F5),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: getBorderColor()),
                ),
                // child: Center(
                //   child: CurrencyPickerDropdown(
                //     initialValue: 'BDT',
                //     itemBuilder: (Country country) {
                //       var code = country.phoneCode;

                //       if (code != null && code.isNotEmpty) {
                //         code = code.substring(0, code.length - 1);
                //       }
                //       userController.code.value = '+$code';
                //       return Text(
                //         '+$code',
                //         style: h3,
                //       );
                //     },
                //     onValuePicked: (v) {
                //       print(v!.phoneCode);
                //     },
                //   ),
                // ),
                child: _buildCupertinoSelectedItem(_selectedCupertinoCountry),
              ),
            ),
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xffF2F3F5),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: getBorderColor()),
                ),
                child: Stack(
                  children: [
                    if (widget.hintText == '')
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            hinttex,
                            style: textstyleh,
                          ),
                        ),
                      ),
                    Focus(
                      onFocusChange: (v) {
                        if (widget.hintText == '') {
                          hinttex = '';
                        }
                      },
                      child: TextField(
                        focusNode: widget.focusNode,
                        autofillHints: const [
                          AutofillHints.telephoneNumber,
                        ],
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                            widget.numberLength,
                          ),
                        ],
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            userController.phoneFlag.value = true;
                          }
                        },
                        cursorHeight: 22,
                        cursorWidth: 1.8,
                        cursorRadius: const Radius.circular(10),
                        controller: widget.controller,
                        textInputAction: TextInputAction.done,
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
                        onSubmitted: (v) {
                          getFocus();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(6),
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
