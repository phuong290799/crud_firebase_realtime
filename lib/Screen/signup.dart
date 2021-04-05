import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Dangky extends StatefulWidget {
  @override
  _DangkyState createState() => _DangkyState();
}

class _DangkyState extends State<Dangky> {
  FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
//  TextEditingController _name = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _user = TextEditingController();
  //TextEditingController _phone = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký'),
      ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.deepPurpleAccent,
                    Colors.white,
                  ]
              )
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(30, 200, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 250,
                  child: TextField(
                    controller: _user,
                    obscureText: false,
                    decoration: InputDecoration(
                        labelText: "Tên đăng nhập",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.black,width: 5),
                        )
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 60,
                    width: 250,
                    child: TextField(
                      controller: _pass,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Mật khẩu",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black,width: 5),
                          )
                      ),

                    )


                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    RaisedButton(onPressed: _dangky2,
                      child: Text("    Đăng ký   ",style: TextStyle(fontSize: 20,color: Colors.black),),
                      color: Colors.amberAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),

                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  void _dangky2(){
    String user= _user.text;
    String pass= _pass.text;

    signup(user, pass);
    Navigator.pop(context);
  }
  void signup(String user, String pass) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: user, password: pass)
        .then((user) {
    }).catchError((err)  {

    });
  }

}
