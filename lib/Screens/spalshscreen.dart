import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uiscreen/MainScreens/createconference.dart';

import 'package:uiscreen/MainScreens/joinconference.dart';
import 'package:uiscreen/Providerdata/shared.dart';
import 'package:uiscreen/Providerdata/Meetingdata.dart';
import 'package:uiscreen/MainScreens/mainscreen.dart';
import 'package:uiscreen/Screens/Loginpage.dart';



class Splash extends StatefulWidget {


  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    AppStatus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStatus>(builder: (context, appstatus, child) {
      return (appstatus.isRegistered)
          ? MainScreen()
        :Login();
  });
}
}