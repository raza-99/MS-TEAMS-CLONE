import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uiscreen/Screens/fp2.dart';
import 'package:firebase_auth/firebase_auth.dart';
class fp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late String emailid;
  final _firebaseAuth=FirebaseAuth.instance;

    Future<void> resetPassword(String email) async {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    }
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
                        'Enter Your Email Id ',
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
                        'Enter your Email id to send reset code '
                            ,
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
                        onChanged: (value){
                          emailid=value;
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          FlatButton(color: Color(0xff4b39ef),minWidth: 150.0,height: 50,onPressed: ()async{
                            print(emailid);
                           await resetPassword(emailid);

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => fp2(resetPassword,emailid)),
                            );

                          },child: Text('Send ',style: TextStyle(color: Colors.white),),)
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
