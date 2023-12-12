import 'dart:ui';

class Obstacle {
  double x;
  double y;
  final double height;
  final double width;

  double v = 4.5;
  double a = 0.00001;
  Obstacle({
    required this.x,
    required this.y,
    required this.height,
    required this.width,
  });
  update(){
    x += -v;
    v += a;
    a += 0.000001;
  }
}
