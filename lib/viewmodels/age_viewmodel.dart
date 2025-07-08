import 'package:flutter/foundation.dart';
import '../models/age_result.dart';
import '../services/age_service.dart';

class AgeViewModel extends ChangeNotifier {
  AgeResult? _ageResult;
  bool _isLoading = false;

  AgeResult? get ageResult => _ageResult;
  bool get isLoading => _isLoading;

  void calculateAge(DateTime birthDate) {
    _isLoading = true;
    notifyListeners();

    _ageResult = AgeService.calculateAge(birthDate);

    _isLoading = false;
    notifyListeners();
  }

  void clearResult() {
    _ageResult = null;
    notifyListeners();
  }
}
