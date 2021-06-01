import 'package:covid_19/constants/country.dart';
import 'package:covid_19/services/CoronaService.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../constants/constant.dart';

class HomeScreen extends StatefulWidget {
  // static Widget screen() => ChangeNotifierProvider(
  //       builder: (context, child) => HomeScreen(),
  //       create: (context) => CoronaProvider(),
  //     );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double offset = 0;
  DateTime selectedDate1;
  DateTime selectedDate2;
  String defaultSlug = "afghanistan";

  void selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate1,
        firstDate: DateTime(2020, 1,23),
        lastDate: DateTime.now().subtract(Duration(days: 2)));
    if (picked != null) {
      selectedDate1 = picked;
      setState(() {});
    }
  }

  void selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        firstDate: DateTime(2020, 1,24),
        lastDate: DateTime.now().subtract(Duration(days: 2)));
    if (picked != null) {
      selectedDate2 = picked;
      setState(() {});
    }
  }

  @override
  void initState() {
    selectedDate1 = DateFormat("dd-MM-yyyy").parse("24-01-2020");
    selectedDate2 = DateTime.now().subtract(Duration(days:2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "Uyda",
              textBottom: "qoling!",
              offset: offset,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Row(children: <Widget>[
                SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                SizedBox(width: 20),
                Expanded(
                  child: DropdownButton(
                    isExpanded: true,
                    underline: SizedBox(),
                    icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                    value: defaultSlug,
                    onChanged: (newvalue) {
                      setState(() {
                        defaultSlug = newvalue;
                      });
                    },
                    items: flagCodes.map((value) {
                      return DropdownMenuItem(
                        child: Text(value['name']),
                        value: value['slug'],
                      );
                    }).toList(),
                  ),
                ),
              ]),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                              border:
                              Border.all(width: 2, color: Colors.black45)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.date_range),
                              Text(DateFormat('dd-MM-yyyy')
                                  .format(selectedDate1.toLocal()))
                            ],
                          ),
                        ),
                        onTap: () => selectDate1(context),
                      ),
                      InkWell(
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                              border:
                              Border.all(width: 2, color: Colors.black45)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.date_range),
                              Text(
                                DateFormat('dd-MM-yyyy')
                                    .format(selectedDate2.toLocal()),
                              )
                            ],
                          ),
                        ),
                        onTap: () => selectDate2(context),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Oxirgi vaziyat\n",
                              style: kTitleTextstyle,
                            ),
                            TextSpan(
                              text: "Oxirgi o'zgarishlar " +
                                  DateFormat('yMMMd').format(DateTime.now()),
                              style: TextStyle(
                                color: kTextLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 20),
                  FutureBuilder(
                    future: CoronaService().getEachCountryData(
                        slug: defaultSlug,
                        timeFrom: DateFormat('dd-MM-yyyy')
                            .format(selectedDate1.toLocal()),
                        timeTo: DateFormat('dd-MM-yyyy')
                            .format(selectedDate2.toLocal())),
                    builder: (context, snapshot) {
                      print("line 228 ${snapshot.data}");
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          return Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 30,
                                  color: kShadowColor,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Counter(
                                  color: kInfectedColor,
                                  number: snapshot.data['confirmed'] ?? 0,
                                  title: "Topilganlar!",
                                ),
                                Counter(
                                  color: kDeathColor,
                                  number: snapshot.data['deaths'] ?? 0,
                                  title: "O'limlar!",
                                ),
                                Counter(
                                  color: kRecovercolor,
                                  number: snapshot.data['recovered'] ?? 0,
                                  title: "Tuzalganlar!",
                                ),
                              ],
                            ),
                          );
                        case ConnectionState.waiting:
                          return Center(child:CircularProgressIndicator());
                        default:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else
                            return Text('Result: ${snapshot.data}');
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Virus tarqalishi",
                        style: kTitleTextstyle,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(20),
                    height: 178,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/map.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}