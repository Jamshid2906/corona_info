import 'dart:convert';

import 'package:covid_19/models/CoronaCountry.dart';
import 'package:covid_19/models/CoronaNewModel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../constants/constant.dart';

class CoronaService {
  Future<Global> getCoronaData() async {
    var url = Uri.https(base_url, '/summary');
    var response = await http.get(url);
    var jsonMapData = json.decode(response.body);
    var global = Global.fromJson(jsonMapData['Global']);

    return global;
  }

  Future<Map<String,int>> getEachCountryData({ String slug = "afghanistan",
    String timeFrom = "23-02-2020",
    String timeTo = "04-03-2021" }) async {
    var result = await http.get(Uri.https(base_url, '/total/country/$slug'));
    var jsonMapData = json.decode(result.body);
    var all = coronaCountryFromJson(jsonMapData);
    Map<String,int> res1 = {};
    Map<String,int> res2 = {};
    all.forEach((element) {
      var dateTime = DateFormat('dd-MM-yyyy').format(element.date.toLocal()).toString();
      if(dateTime == timeFrom ){
        print("line 30: $dateTime");
        res1.addAll({
          'confirmed' : element.confirmed,
          'deaths'    : element.deaths,
          'recovered' : element.recovered,
        });
      } else if (dateTime == timeTo){
        res2.addAll({
          'confirmed' : element.confirmed,
          'deaths'    : element.deaths,
          'recovered' : element.recovered,
        });
      }
    });
    Map<String,int> response = {};
    response.addAll({
      'confirmed' : res2['confirmed'] - res1['confirmed'],
      'deaths'    : res2['deaths']    - res1['deaths'],
      'recovered' : res2['recovered'] - res1['recovered']
    });
    return response;
  }
}