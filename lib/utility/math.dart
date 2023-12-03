import 'dart:math';
import 'dart:ui';

double abs(double n) => n < 0 ? n * -1 : n;

double offsetDistance(Offset a, Offset b){
  double x = a.dx - b.dx;
  double y = a.dy - b.dy;
  return sqrt(abs(x*x - y*y));
}
