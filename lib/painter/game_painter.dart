import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:run_dino_run/const.dart';

class GamePainter extends CustomPainter {

  static Offset dinoPosition = Offset.zero;
  static Size _canvasSize = Size.zero;
  static Offset _currentDinoPosition = Offset.zero;
  static Offset _initPos = Offset.zero;

  void setDinoPosition(double x, double y){
    dinoPosition = Offset(x,y);
  }

  Size get canvasSize => _canvasSize;
  Offset get dinoCurrentPosition => _currentDinoPosition;
  Offset get dinoInitPosition => _initPos;
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
    _initPos = Offset(DINO_LEFT_MARGIN, size.height - GROUND_BOTTOM_MARGIN - 40);
    pos += _initPos;
    _currentDinoPosition = pos;
    _debugPoint(canvas, pos);
    _debugPoint(canvas, Offset(DINO_LEFT_MARGIN, size.height - GROUND_BOTTOM_MARGIN));
    Rect rect = pos & const Size(DINO_VIEWPORT_WIDTH, DINO_VIEWPORT_HEIGHT);
    canvas.drawRect(rect, dinoPaint);
  }
  _drawGround(Canvas canvas,Size size){
    Paint groundPaint = Paint()..color = Colors.brown..strokeWidth=1;
    Offset startOffset = Offset(0, size.height - GROUND_BOTTOM_MARGIN);
    Offset endOffset = Offset(size.width, size.height - GROUND_BOTTOM_MARGIN);
    canvas.drawLine(startOffset, endOffset, groundPaint);
  }
  _debugPoint(Canvas canvas,Offset offset){
    canvas.drawCircle(offset, 2, Paint()..color = Colors.red);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
