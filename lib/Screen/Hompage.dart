import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:managerstudent_getx/Screen/Addlist.dart';
import 'package:managerstudent_getx/Screen/ListView.dart';
import 'package:managerstudent_getx/Screen/Login.dart';

class Hompage extends StatefulWidget {
  @override
  _HompageState createState() => _HompageState();
}

class _HompageState extends State<Hompage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Container(child: Text("Lựa chọn",style: TextStyle(fontSize: 22,color: Colors.black),),
        ),
      ),
      drawer: new Drawer(
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.yellow,
                ]),
          ),
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 15,
                ),
                Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.lightGreenAccent,
                            Colors.yellow,
                          ]),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.yellow, width: 5),
                    ),
                    height: 140,
                    child: TextButton(
                      child: Center(
                        child: Text(
                          "Xem danh sách sinh viên",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Viewlist()));
                      },
                    ),
                  ),

                ]),
                SizedBox(
                  height: 15,
                ),
                Stack(children: [
                  Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.greenAccent,
                              Colors.yellow,
                            ]),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.yellow, width: 5),
                      ),
                      height: 140,
                      child:TextButton(
                        child: Center(
                          child: Text(
                            "Thêm sinh viên",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Add()));
                        },
                      )),

                ]),
                SizedBox(
                  height: 15,
                ),
                Stack(children: [
                  Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.lightGreen,
                              Colors.yellow,
                            ]),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.yellow, width: 5),
                      ),
                      height: 140,
                      child: TextButton(
                        child: Center(
                          child: Text(
                            "Đăng xuất",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                      )),

                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
