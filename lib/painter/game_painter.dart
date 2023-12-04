import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:run_dino_run/const.dart';
import 'dart:ui' as ui;

import '../game_object/dino.dart';
class GamePainter extends CustomPainter {

  Offset dinoPosition = Offset.zero;
  static Size _canvasSize = Size.zero;
  static Offset _currentDinoPosition = Offset.zero;
  static Offset _initPos = Offset.zero;

   ui.Image img;
   int index;
  GamePainter(this.img,this.dinoPosition,this.index);

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
    double w = (img.width / 7) ;
    double h = img.height + 0.0;
    Rect r = Offset(w*index - 30, 30) & Size(w, h);
    Rect r1 = Offset((size.width - 100)/2 ,(size.height - 100)/2) & Size(200, 200);
    canvas.drawImageRect(img,r,r1,Paint());
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
