import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NeuButton extends StatefulWidget {
  final String text;
  // final Color textColor;
  final Color buttonColor;
  final double textsize;
  final Function callback;

  const NeuButton({
    required this.text,
    // required this.textColor,
    this.buttonColor: Colors.blue,
    this.textsize: 24,
    required this.callback,
  });

  @override
  _NeuButtonState createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton> {
  bool _isPressed = false;
  void _onPointerDown(PointerDownEvent) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => widget.callback(widget.text),
      child: Listener(
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  widget.buttonColor.withOpacity(0.5),
                  widget.buttonColor.withOpacity(0.6),
                  widget.buttonColor.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              // borderRadius: BorderRadius.circular(10),
              color: widget.buttonColor,
              boxShadow: _isPressed
                  ? null
                  : Get.isDarkMode
                      ? [
                          BoxShadow(
                            offset: Offset(4, 4),
                            spreadRadius: 1,
                            blurRadius: 10,
                            color: Colors.black,
                          ),
                          BoxShadow(
                            offset: Offset(-4, -4),
                            color: Colors.white12,
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ]
                      : [
                          BoxShadow(
                            offset: Offset(4, 4),
                            spreadRadius: 1,
                            blurRadius: 10,
                            color: Colors.grey,
                          ),
                          BoxShadow(
                            offset: Offset(-4, -4),
                            color: Colors.white,
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
            ),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: widget.textsize,
                  color: Get.isDarkMode ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
