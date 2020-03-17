
import 'package:fit_kit/fit_kit.dart';

extension FitDataExtension on FitData {
  Map<String, dynamic> toJson() => {
    'value': value,
    'dateFrom': dateFrom.toIso8601String(),
    'dateTo': dateTo.toIso8601String(),
    'source': source,
    'userEntered': userEntered,
  };
}