import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? borderColor;
  double? height;
  double? width;
  final Color? backGroundColor;
  double? radius;
  EdgeInsets? margin;

  MyContainer(
      {Key? key,
      this.height,
      this.width,
      required this.child,
      this.padding,
      this.borderColor,
      this.radius,
      this.backGroundColor,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: backGroundColor ?? Colors.transparent,
        border: Border.all(
          color: borderColor ?? Colors.black,
          width: 1.3, //                   <--- border width here
        ),
        borderRadius: BorderRadius.circular(radius ?? 12),
      ),
      child: child,
    );
  }
}
