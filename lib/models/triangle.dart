enum TriangleType {
  equilateral,
  isosceles,
  scalene,
  noTriangle,
}

class Triangle {
  final double side1;
  final double side2;
  final double side3;
  final TriangleType type;

  Triangle({
    required this.side1,
    required this.side2,
    required this.side3,
    required this.type,
  });
}
