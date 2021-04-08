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
        backgroundColor: Colors.purpleAccent,
        actions: [
          Center(
              child: Row(
            children: [
              Icon(Icons.account_box_outlined),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    "Thoát",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ))
        ],

        title: Container(
          child: Text(
            "Home",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),

      ),

      drawer: new Drawer(
        child: Container(
            child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Icon(Icons.account_circle_outlined,size: 30,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Chào bạn",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(color: Colors.lightBlue),
            ),
            ListTile(
              title: Text("Trang chủ",
            style: TextStyle(fontSize: 20, color: Colors.black)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Viewlist()));
              },
            ),
            ListTile(
              title: Text("Đăng xuất",style: TextStyle(fontSize: 20, color: Colors.black)),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        )),
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
                  Colors.white,
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
                    border: Border.all(color: Colors.yellow, width: 1),
                  ),
                  height: 100,
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Viewlist()));
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
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
                      border: Border.all(color: Colors.yellow, width: 1),
                    ),
                    height: 100,
                    child: TextButton(
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
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
