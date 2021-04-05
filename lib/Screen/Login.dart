import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:managerstudent_getx/Screen/Hompage.dart';
import 'package:managerstudent_getx/Screen/signup.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  TextEditingController _namedn = TextEditingController();
  TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  controller: _namedn,
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

                  RaisedButton(
                    onPressed: _dangnhap,
                    child: Text("Đăng nhập",style: TextStyle(fontSize: 20,color: Colors.black),),
                      color: Colors.amberAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),

                      ),
                  ),
                  SizedBox(
                    width: 30,
                  ),

                  RaisedButton(onPressed: _dangky,
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
  void _dangnhap(){
    String user = _namedn.text;
    String pass = _pass.text;
    _fireBaseAuth.signInWithEmailAndPassword(email: user, password: pass)
        .then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Hompage()));
    });
  }
  void _dangky(){

    Navigator.push(context, MaterialPageRoute(builder: (context)=> Dangky()));

  }
}
