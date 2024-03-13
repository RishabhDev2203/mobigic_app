import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  Key? key;
  String? text;
  double? width;
  double? height;
  double? fontSize;
  String? fontStyle;
  Color? backgroundColor;
  Color? borderColor;
  Color? fontColor;
  VoidCallback? onClicked;
  bool enableAnimation;
  double? borderRadius;

  PrimaryButton(
      {this.key,
      required this.text,
      this.width,
      this.height,
      this.fontSize,
      this.fontStyle,
      this.backgroundColor,
      this.onClicked,
      this.enableAnimation = true,
      this.borderColor,
      this.fontColor,
      this.borderRadius})
      : super(key: key);

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  AnimationController? _controller;

  @override
  void initState() {
    if (widget.enableAnimation) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 50,
        ),
        lowerBound: 0.0,
        upperBound: 0.1,
      )..addListener(() {
          setState(() {});
        });
    } else {
      _controller = null;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null) {
      _scale = 1 - _controller!.value;
    } else {
      _scale = 0.0;
    }
    return widget.enableAnimation
        ? GestureDetector(
            onTapDown: _tapDown,
            onTapUp: _tapUp,
            onTap: widget.onClicked,
            onTapCancel: _tapCancel,
            child: Transform.scale(
              scale: _scale,
              child: _buttonWidget(),
            ),
          )
        : InkWell(
            onTap: widget.onClicked,
            child: _buttonWidget(),
          );
  }

  void _tapDown(TapDownDetails details) {
    _controller?.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller?.reverse();
  }

  void _tapCancel() {
    _controller?.reverse();
  }

  _buttonWidget() {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height ?? 40,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
          border: Border.all(
              color: widget.borderColor ?? Colors.transparent, width: 0.8),
          color: widget.backgroundColor ?? Colors.black),
      child: Center(
        child: Text(
          widget.text != null ? widget.text! : "",
          style: TextStyle(
              fontSize: widget.fontSize ?? 16,
              color: widget.fontColor ?? Colors.white,
              letterSpacing: 1,
              fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
