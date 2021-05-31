import 'dart:ui';

import 'package:covid_19/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FrontHome extends StatefulWidget {
  @override
  _FrontHomeState createState() => _FrontHomeState();
}

class _FrontHomeState extends State<FrontHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Corona info',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 39,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                child: Image.asset("assets/images/home_corona.jpg"),
                // color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    width: 0.8 * MediaQuery.of(context).size.width,
                    height: 40,
                    child: Center(
                        child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
