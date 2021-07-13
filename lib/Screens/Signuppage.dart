import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:uiscreen/MainScreens/mainscreen.dart';
import 'package:uiscreen/MainScreens/createconference.dart';
import 'package:uiscreen/Providerdata/Meetingdata.dart';
import 'package:uiscreen/Providerdata/shared.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

   late String email;
   late String pass;
   String subtitle="Sign up to create a new account by entering your information below";

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        'Sign Up',
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
                        '$subtitle',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color(0xff605f5f),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(
                            fontSize: 25.0,
                            color: Color(0xff939292),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          pass = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 25.0,
                            color: Color(0xff939292),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            color: Color(0xff4b39ef),
                            minWidth: 150.0,
                            height: 50,
                            onPressed: () async {

                              try{
                                final newUser=  await _auth.createUserWithEmailAndPassword(email: email, password: pass);

                                if(newUser!=null){
                                  AppStatus().CheckPermission();
                                  AppStatus().setemail(email);//setting email in shared pref
                                  Provider.of<Meetingdata>(context, listen: false)
                                      .getemail(email);

                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()),
                                );

                                }

                              }catch(e){
                                print(e);
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),


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
