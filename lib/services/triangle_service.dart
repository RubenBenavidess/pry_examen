import '../models/triangle.dart';

class TriangleService {
  static Triangle classifyTriangle(double side1, double side2, double side3) {
    // Validar que los lados formen un triángulo
    if (!_isValidTriangle(side1, side2, side3)) {
      return Triangle(
        side1: side1,
        side2: side2,
        side3: side3,
        type: TriangleType.noTriangle,
      );
    }

    // Clasificar el triángulo
    TriangleType type;
    if (side1 == side2 && side2 == side3) {
      type = TriangleType.equilateral;
    } else if (side1 == side2 || side2 == side3 || side1 == side3) {
      type = TriangleType.isosceles;
    } else {
      type = TriangleType.scalene;
    }

    return Triangle(
      side1: side1,
      side2: side2,
      side3: side3,
      type: type,
    );
  }

  static bool _isValidTriangle(double a, double b, double c) {
    return (a + b > c) && (a + c > b) && (b + c > a);
  }
}
