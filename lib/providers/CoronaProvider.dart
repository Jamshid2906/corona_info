import 'package:flutter/material.dart';
import 'package:covid_19/services/CoronaService.dart';
import 'package:intl/intl.dart';

class CoronaProvider extends ChangeNotifier {
  int count = 0;
  var selectedDate1 = DateFormat("dd-MM-yyyy").parse("24-01-2020");
  var selectedDate2 = DateTime.now();
  String defaultSlug = "afghanistan";

  Map<String,int> items = {};

  void selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate1,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime.now());
    if (picked != null) {
      selectedDate1 = picked;
      notifyListeners();
      this.apiEachCountry();
    }
  }

  void selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime.now());
    if (picked != null) {
      selectedDate2 = picked;
      notifyListeners();
      this.apiEachCountry();
    }
  }

  void changeSelect(newvalue) {
    defaultSlug = newvalue;
    notifyListeners();
    this.apiEachCountry();
  } 

  //
  void apiEachCountry() {
   CoronaService().getEachCountryData(
        slug: defaultSlug,
        timeFrom: selectedDate1.toString(),
        timeTo: selectedDate2.toString());
    notifyListeners();    
    print([defaultSlug,selectedDate1,selectedDate2]);
  }
}
