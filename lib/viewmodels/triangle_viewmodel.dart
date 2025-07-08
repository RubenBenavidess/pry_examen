import 'package:flutter/foundation.dart';
import '../models/triangle.dart';
import '../services/triangle_service.dart';

class TriangleViewModel extends ChangeNotifier {
  Triangle? _triangle;
  bool _isLoading = false;

  Triangle? get triangle => _triangle;
  bool get isLoading => _isLoading;

  void classifyTriangle(double side1, double side2, double side3) {
    _isLoading = true;
    notifyListeners();

    _triangle = TriangleService.classifyTriangle(side1, side2, side3);

    _isLoading = false;
    notifyListeners();
  }

  void clearResult() {
    _triangle = null;
    notifyListeners();
  }

  String getTriangleTypeText(TriangleType type) {
    switch (type) {
      case TriangleType.equilateral:
        return 'Equilátero';
      case TriangleType.isosceles:
        return 'Isósceles';
      case TriangleType.scalene:
        return 'Escaleno';
      case TriangleType.noTriangle:
        return 'No es un triángulo válido';
    }
  }
}
