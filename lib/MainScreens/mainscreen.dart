import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:uiscreen/MainScreens/createconference.dart';
import 'package:uiscreen/MainScreens/joinconference.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: pageChanged,
          children:<Widget> [
            createcon(),
            JoinCon(),]
          ,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,

selectedItemColor:Color(0xffF40612) ,
          currentIndex: _page,
          onTap: Tapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.video_call,
                color: Colors.white,

              ),
              title: Text("Create Meeting",),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.meeting_room,color: Colors.white,), title: Text("Join Meeting",)),
          ],
        ),
      ),
      onWillPop: () => _ConfirmExit(context),
    );
  }

  void Tapped(pageindex) {
   _pageController.jumpToPage(pageindex);
  }

  _ConfirmExit(context) {
    showDialog(
barrierColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Are you sure to exit?',style: TextStyle(color:Colors.white),),
          content: Text("You will not be connected",style: TextStyle(color: Colors.white),),
          actions: [
            FlatButton(onPressed: () => exit(0), child: Text('Yes',style: TextStyle(color: Color(0xffF40612)),)),
            FlatButton(
                onPressed: () => Navigator.pop(context), child: Text('No',style: TextStyle(color: Color(0xffF40612)),)),
          ],
        );
      },
    );
  }

  void pageChanged(pageindex) {
    setState(() {
      this._page = pageindex;
    });
  }
}
