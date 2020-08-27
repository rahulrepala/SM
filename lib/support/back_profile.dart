import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackProfile extends CustomPainter {
  final cont;
  BackProfile(this.cont);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Color(0xff2f2d51);
    // color: Color.fromRGBO(63, 92, 200, 1),
    var path = Path();
   path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}