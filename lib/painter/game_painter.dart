import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:run_dino_run/const.dart';
import 'dart:ui' as ui;

import '../game_object/dino.dart';
import '../game_object/obstacle.dart';

class GamePainter extends CustomPainter {
  Offset dinoPosition = Offset.zero;
  static Size _canvasSize = Size.zero;
  static Offset _currentDinoPosition = Offset.zero;
  static Offset _initPos = Offset.zero;
  ui.Image dinoImg;
  int spriteImgIndex;
  List<Obstacle> obstaclesList;
  GamePainter(
      {required this.dinoImg,
      required this.dinoPosition,
      required this.spriteImgIndex,
      required this.obstaclesList});

  void setDinoPosition(double x, double y) {
    dinoPosition = Offset(x, y);
  }

  Size get canvasSize => _canvasSize;
  Offset get dinoCurrentPosition => _currentDinoPosition;
  Offset get dinoInitPosition => _initPos;
  @override
  void paint(Canvas canvas, Size size) {
    _drawGround(canvas, size);
    _drawDino(canvas, size, -dinoPosition);
    _drawObstacles(canvas, size);
    // set canvas size
    _canvasSize = size;
    // _sprite(size, canvas);
    //_debugPoint(canvas, Offset(size.width, size.height));
    //  log("${size.height} * ${size.width}");
  }

  void _sprite(Size size, Canvas canvas, Rect pos) {
    double w = (dinoImg.width / 5);
    double h = dinoImg.height + 0.0;
    Rect r = Offset(w * spriteImgIndex, 0) & Size(w, h);
    Rect r1 = pos;
    //  _debugRect(canvas, r1);
    canvas.drawImageRect(dinoImg, r, r1, Paint());
  }

  _drawDino(Canvas canvas, Size size, Offset pos) {
    Paint dinoPaint = Paint()..color = Colors.green;
    _initPos = Offset(DINO_LEFT_MARGIN,
        size.height - DINO_VIEWPORT_HEIGHT - GROUND_BOTTOM_MARGIN);
    pos += _initPos;
    _currentDinoPosition = pos;
    _debugPoint(canvas, pos);
    _debugPoint(
        canvas, Offset(DINO_LEFT_MARGIN, size.height - GROUND_BOTTOM_MARGIN));
    Rect rect = pos & const Size(DINO_VIEWPORT_WIDTH, DINO_VIEWPORT_HEIGHT);
    _sprite(size, canvas, rect);
  }

  _drawObstacles(Canvas canvas, Size size) {
    for (Obstacle obstacle in obstaclesList) {
      Offset obstaclePosition = Offset(size.width,
              size.height - obstacle.height - GROUND_BOTTOM_MARGIN) +
          Offset(obstacle.x, obstacle.y);
      Rect r = obstaclePosition & Size(obstacle.width, obstacle.height);
      obstacle.checkOutOfViewport(obstaclePosition, size);
      _debugRect(canvas, r);

    }
  }

  _drawGround(Canvas canvas, Size size) {
    Paint groundPaint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 1;
    Offset startOffset = Offset(0, size.height - GROUND_BOTTOM_MARGIN);
    Offset endOffset = Offset(size.width, size.height - GROUND_BOTTOM_MARGIN);
    canvas.drawLine(startOffset, endOffset, groundPaint);
  }

  _debugPoint(Canvas canvas, Offset offset) {
    canvas.drawCircle(offset, 2, Paint()..color = Colors.red);
  }

  _debugRect(Canvas canvas, Rect r) {
    Paint p = Paint()
      ..strokeWidth = 2
      ..color = Colors.red;
    canvas.drawRect(r, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
