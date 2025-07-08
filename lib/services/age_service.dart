import '../models/age_result.dart';

class AgeService {
  static AgeResult calculateAge(DateTime birthDate) {
    DateTime now = DateTime.now();

    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(now.year, now.month, 0).day;
    }

    if (months < 0) {
      years -= 1;
      months += 12;
    }

    return AgeResult(years: years, months: months, days: days);
  }
}
