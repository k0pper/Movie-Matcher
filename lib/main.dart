import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipecards/pages/authpage.dart';
import 'package:swipecards/pages/creategroup/addpeople.dart';
import 'package:swipecards/pages/rootpage.dart';
import 'package:get_it/get_it.dart';
import 'package:swipecards/services/nav.dart';

GetIt locator = GetIt();
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}

void main() {
  setupLocator();
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color primaryColor = Color(0xFFF46036);
  Color secondaryColor = Colors.grey[900];

  Curve animationCurve = Curves.linear;
  int animationDuration = 100;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Roboto',
          primaryColor: primaryColor,
          primaryColorLight: secondaryColor,
        ),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: (routeSettings) {
          switch (routeSettings.name) {
            case 'login':
              return MaterialPageRoute(builder: (context) => AuthPage());
            case 'root':
              return MaterialPageRoute(builder: (context) => RootPage());
            case 'addPeople':
              return MaterialPageRoute(builder: (context) => AddPeople());
            default:
              return MaterialPageRoute(builder: (context) => AuthPage());
          }
        },
        home: AuthPage());
  }
}
