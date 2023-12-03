import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:run_dino_run/const.dart';

class GamePainter extends CustomPainter {

  static Offset dinoPosition = Offset.zero;
  static Size _canvasSize = Size.zero;
  void setDinoPosition(double x, double y){
    dinoPosition = Offset(x,y);
  }
  Size get canvasSize => _canvasSize;
  @override
  void paint(Canvas canvas, Size size) {
    _drawGround(canvas, size);
    _drawDino(canvas, size, -dinoPosition);

    // set canvas size
    _canvasSize = size;
    //_debugPoint(canvas, Offset(size.width, size.height));
  //  log("${size.height} * ${size.width}");
  }

  _drawDino(Canvas canvas,Size size,Offset pos){
    Paint dinoPaint = Paint()..color = Colors.green;
    Offset initPos = Offset(30, size.height - groundBottomMargin - 40);
    pos += initPos;
    _debugPoint(canvas, pos);
    Rect rect = pos & const Size(40, 40);
    canvas.drawRect(rect, dinoPaint);
  }
  _drawGround(Canvas canvas,Size size){
    Paint groundPaint = Paint()..color = Colors.brown;
    Offset startOffset = Offset(0, size.height - groundBottomMargin);
    Offset endOffset = Offset(size.width, size.height - groundBottomMargin);
    canvas.drawLine(startOffset, endOffset, groundPaint);
  }
  _debugPoint(Canvas canvas,Offset offset){
    canvas.drawCircle(offset, 3, Paint()..color = Colors.red);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
