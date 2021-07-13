import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class fp2 extends StatefulWidget {
  late Function fun;
  fp2(this.fun,this.emailid);
  late String emailid;
  @override
  _fp2State createState() => _fp2State();

}

class _fp2State extends State<fp2> {
  late Timer _timer;
  int _start = 90;
  late bool _isbuttondisabled;


  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
_isbuttondisabled=false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  void startagain(){
    setState(() {
      _start = 90;
      startTimer();
    });
  }
  void toggle(){
    _isbuttondisabled=!_isbuttondisabled;
  }
  Widget _buildcounter(BuildContext context) {
    return new FlatButton(
      onPressed: () {
        _isbuttondisabled?null:startagain();
        toggle();
      },
      child:new Text(
          _isbuttondisabled?'Hold on':"Resend",

        style: TextStyle(
          color: Colors.white
        ),
      )

    );
  }

  @override
  void initState() {
    startTimer();
    _isbuttondisabled = true;
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0b202c),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/mlogo.png',
              height: 20,
              width: 20,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text('Microsoft Teams')
          ],
        ),
      ),
      backgroundColor: Color(0xff1d2429),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reset link is sent to your Email ',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Please wait for 90 seconds  ',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color(0xff605f5f),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            color: Color(0xff4b39ef),
                            minWidth: 150.0,
                            height: 50,
                            onPressed: () {

widget.fun(widget.emailid);

                            },
                            child: Text(
                              'Try again ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                         _buildcounter(context)
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$_start seconds",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





