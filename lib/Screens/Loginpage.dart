

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uiscreen/MainScreens/mainscreen.dart';
import 'package:uiscreen/Providerdata/shared.dart';
import 'package:uiscreen/Screens/Signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'fp1.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {

    final _auth=FirebaseAuth.instance;
   late String email;
   late String pass;
   late String dumm="Sign into your account by entering your information below";
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
                                'Login',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),

                              Text(
                                '$dumm',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xff605f5f),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextField(
                                style: TextStyle(color: Colors.white),
                                onChanged: (value){
                                  email=value;
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
                                height: 20.0,
                              ),
                              TextField(
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                                onChanged: (value){
                                  pass=value;
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
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => fp1()),
                                        );
                                      },
                                      child: Text('Forget password ??',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ))),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  FlatButton(
                                    color: Color(0xff4b39ef),
                                    minWidth: 150.0,
                                    height: 50,
                                    onPressed: ()async {

                                      try{
                                        final user=await _auth.signInWithEmailAndPassword(email: email, password: pass);

                                        if(user!=null){
                                          AppStatus().CheckPermission();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>MainScreen()),
                                          );
                                        }
                                      }catch(e){
                                       print(e);
                                      }

                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlatButton(
                                      onPressed: () {},
                                      child: Text("Don't have an account??",
                                          style: TextStyle(
                                            color: Color(0xff605f5f),
                                          ))),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      // Within the `FirstRoute` widget

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signup()),
                                      );
                                    },
                                    child: Text(
                                      'Create Account',
                                      style:
                                          TextStyle(color: Color(0xffe27745)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
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
