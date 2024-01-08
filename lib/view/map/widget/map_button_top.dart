import 'package:flutter/material.dart';

class MapButton extends StatefulWidget {
  final bool value;
  final double width;
  final double height;
  final Function(bool) onChanged;
  final String textOff;
  final double fontSize;
  final String textOn;
  final Color textOnColor;
  final Color colorOn;
  final Color colorOff;
  final double textSize;
  final Duration animationDuration;
  final IconData iconOn;
  final IconData iconOff;
  final Function onTap;
  final Function onDoubleTap;
  final Function onSwipe;
  const MapButton({
    Key? key,
    this.value = false,
    this.width = 130,
    this.height = 100,
    this.textOff = "LISS",
    this.textOn = "MAP",
    this.textSize = 14.0,
    this.colorOn = Colors.green,
    this.colorOff = Colors.red,
    this.iconOff = Icons.flag,
    this.iconOn = Icons.check,
    this.animationDuration = const Duration(milliseconds: 600),
    this.textOnColor = Colors.black,
    required this.onTap,
    required this.onDoubleTap,
    required this.onSwipe,
    required this.onChanged,
    this.fontSize = 30,
  }) : super(key: key);

  @override
  State<MapButton> createState() => _MapButtonState();
}

class _MapButtonState extends State<MapButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late bool turnState;
  double value = 0.0;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (turnState) {
          animationController.forward();
        }
      });
    });
  }

  _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();

      widget.onChanged(turnState);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? transitionColor = Color.lerp(widget.colorOff, widget.colorOn, value);
    return GestureDetector(
      onDoubleTap: () {
        _action();
        widget.onDoubleTap();
      },
      onTap: () {
        _action();
        widget.onTap();
      },
      onPanEnd: (details) {
        _action();
        widget.onSwipe();
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: const Color(0xffF0F0F0),
            borderRadius: BorderRadius.circular(50)),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: isRTL(context)
                  ? Offset(-10 * value, 0)
                  : Offset(10 * value, 0),
              child: Opacity(
                opacity: (1 - value).clamp(0.0, 1.0),
                child: Container(
                  padding: isRTL(context)
                      ? const EdgeInsets.only(left: 10)
                      : const EdgeInsets.only(right: 10),
                  alignment: isRTL(context)
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  height: 40,
                  child: Text(
                    widget.textOff,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: isRTL(context)
                  ? Offset(-10 * (1 - value), 0)
                  : Offset(10 * (1 - value), 0),
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Container(
                  padding: isRTL(context)
                      ? const EdgeInsets.only(right: 5)
                      : const EdgeInsets.only(left: 5),
                  alignment: isRTL(context)
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  height: 40,
                  child: Text(
                    widget.textOn,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: isRTL(context)
                  ? Offset((-widget.width + 50) * value, 0)
                  : Offset((widget.width - 50) * value, 0),
              child: Transform.rotate(
                angle: 0,
                child: Container(
                  height: 35,
                  width: 35,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Opacity(
                          opacity: (1 - value).clamp(0.0, 1.0),
                          child: Icon(
                            widget.iconOff,
                            size: 25,
                            color: transitionColor,
                          ),
                        ),
                      ),
                      Center(
                        child: Opacity(
                          opacity: value.clamp(0.0, 1.0),
                          child: Icon(
                            widget.iconOn,
                            size: 21,
                            color: transitionColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

bool isRTL(BuildContext context) {
  return Directionality.of(context) == TextDirection.rtl;
}
