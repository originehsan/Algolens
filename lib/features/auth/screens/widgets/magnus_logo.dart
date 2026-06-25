import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MagnusLogo extends StatelessWidget {
  const MagnusLogo({
    super.key,
    this.size = 80,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/magnus_logo.png',
      width: size.r,
      height: size.r,
    );
  }
}