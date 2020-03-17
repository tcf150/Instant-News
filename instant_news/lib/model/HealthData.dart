
import 'package:fit_kit/fit_kit.dart';
import 'package:instant_news/model/FitData_extension.dart';

class HealthData {
  final String token;
  final List<FitData> fitDataList;
  HealthData(this.token,
      this.fitDataList,);

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> fitDataListJson = fitDataList.map((data) => data.toJson()).toList();
    
    return {
      'token': token,
      'fitDataList': fitDataListJson,
    };
  }

}