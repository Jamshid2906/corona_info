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
  final controller = ScrollController();
  double offset = 0;
  var someValue;
  DateTime selectedDate1 = DateFormat("dd-MM-yyyy").parse("24-01-2020");
  DateTime selectedDate2 = DateTime.now();
  String defaultSlug = "afghanistan";

  dynamic items = {};

  void selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate1,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime.now());
    if (picked != null) {
      selectedDate1 = picked;
      setState(() {});
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
      setState(() {});
      this.apiEachCountry();
    }
  }

  void changeSelect(newvalue) {
    defaultSlug = newvalue;
    setState(() {});
    this.apiEachCountry();
  } 

  //
  void apiEachCountry() {
   items = CoronaService().getEachCountryData(
        slug: this.defaultSlug,
        timeFrom: this.selectedDate1.toString(),
        timeTo: this.selectedDate2.toString());
        // items.addAll();
    print(items);
    setState(() {});
    print("item  runttype ${items.runtimeType}");
    print([defaultSlug,selectedDate1,selectedDate2]);
  }
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    this.someValue = CoronaService().getEachCountryData();
    super.initState();
    controller.addListener(onScroll);
    print('initstate ${someValue}');
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
        body: SingleChildScrollView(
          controller: controller,
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
                      onChanged: (newvalue) => changeSelect(newvalue),
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
                                border: Border.all(
                                    width: 2, color: Colors.black45)),
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
                            decoration:  BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                    width: 2, color: Colors.black45)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.date_range),
                                Text(DateFormat('dd-MM-yyyy')
                                    .format(selectedDate2.toLocal()))
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
                    Container(
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
                      child: (true) ?
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Counter(
                                  color: kInfectedColor,
                                  number: (items != null) ? items['confirmed'] : someValue['confirmed'],
                                  title: "Topilganlar!",
                                ),
                              Counter(
                                  color: kDeathColor,
                                  number: (items != null) ? items['deaths'] : someValue['death'],
                                  title: "O'limlar!",
                                ),
                              Counter(
                                  color: kRecovercolor,
                                  number: (items != null) ? items['recovered'] : someValue['recovered'],
                                  title: "Tuzalganlar!",
                                ),
                              ],
                            ) :
                            Center(child: CircularProgressIndicator()),
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
        // body: Text('Some'),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // print(DateFormat('dd-MM-yyyy')
            //     .format(proValue.selectedDate1.toLocal()));
            // print(DateFormat('dd-MM-yyyy')
            //     .format(proValue.selectedDate2.toLocal()));
            // print(proValue.item);
            // CoronaService net = CoronaService();
            // final some = net.getEachCountryData(
            //     timeFrom: proValue.selectedDate1.toString(),
            //     timeTo: proValue.selectedDate2.toString());
            // CoronaService ob = CoronaService(); 
            // var item = ob.getEachCountryData();
            // print(item);
            // print(proValue.defaultSlug);
            apiEachCountry();
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
  }
}
