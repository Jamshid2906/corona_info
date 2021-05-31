import 'package:covid_19/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/constants/constant.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid 19',
        theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            fontFamily: "Poppins",
            textTheme: TextTheme(
              body1: TextStyle(color: kBodyTextColor),
            )),
        // home: HomeScreen(),
        home: SplashScreenView(
            navigateRoute: MyHomePage(),
            duration: 2000,
            imageSize: 370,
            imageSrc: 'assets/images/home_corona.jpg',
            text: "Corona Info",
            textType: TextType.ScaleAnimatedText,
            textStyle: TextStyle(
              fontSize: 30.0,
            ),
            backgroundColor: Colors.white,
          )
        );
  }
}
