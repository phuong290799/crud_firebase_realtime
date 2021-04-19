
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:managerstudent_getx/Controller/controller.dart';
import 'package:managerstudent_getx/Home/Drawer.dart';
import 'package:managerstudent_getx/Home/cardStudent.dart';
import 'package:managerstudent_getx/Models/studentObj.dart';
import 'package:managerstudent_getx/Screen/Addlist.dart';
import 'package:managerstudent_getx/Screen/Login.dart';
import 'package:managerstudent_getx/Theme/colors.dart';
import 'package:managerstudent_getx/Theme/style.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<StudentObj> dataList = [];
  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance.reference().child("users").once().then((DataSnapshot dataSnapshot) {
      dataList.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        print("Key : " + key);
        StudentObj data = new StudentObj(
          values[key]["image"],
          values[key]["name"],
          values[key]["tuoi"],
          values[key]["phone"],
          values[key]["address"],
          values[key]["diem"],
          key,
        );
        dataList.add(data);
      }
      setState(() {});
    });
  }

  Controller _controllerhome = Get.put(Controller());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: Drawer(
        child: OpenDrawer(),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text('Trang chủ', style: AppThemes.Text20Bold),
        backgroundColor: AppColors.Scaffor,
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset("assets/images/cart1.png"),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
            },
            child: Image.asset('assets/images/admin.png',height: 35,width: 35,),
          ),
          SizedBox(width: 20,),

        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(140),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text('Chào mừng bạn đến với trang\nQuản lý sinh viên',
                      style: AppThemes.Text16Medium),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color:AppColors.Scaffor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(0, 0), // Shadow position
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Icon(Icons.search),
                      SizedBox(width: 10,),
                      Container(
                        height: 52,
                        width: 250,

                        child: Center(
                          child: TextField(
                            decoration: InputDecoration.collapsed(
                              hintText: "Search ",
                              hintStyle: AppThemes.Text14,
                            ),
                            onChanged: (text) {
                              search(text);
                            },
                          ),

                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.BACKGROUND,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),

                          ),
                        ),

                        child: Icon(Icons.person_search_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               Container(
                 padding: EdgeInsets.all(10),
                 height: 500,
              child: dataList.length == 0
                  ? Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              )
                  : Container(

                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: CardStudent(
                           image: dataList[index].image,
                           name: dataList[index].name,
                            tuoi:dataList[index].tuoi,
                            phone:dataList[index].phone,
                            address:dataList[index].address,
                           diem: dataList[index].diem,
                            keyy: dataList[index].key),
                      );
                    }),
              ),
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
void search(String text) {
  DatabaseReference searchref =
      FirebaseDatabase.instance.reference().child("users");
  searchref.once().then((DataSnapshot dataSnapshot) {
    dataList.clear();
    var keys = dataSnapshot.value.keys;
    var values = dataSnapshot.value;
    for (var key in keys) {
      StudentObj data = new StudentObj(
        values[key]["image"],
        values[key]["name"],
        values[key]["tuoi"],
        values[key]["phone"],
        values[key]["address"],
        values[key]["diem"],
        key,
      );

      if (data.name.contains(text)) {
        dataList.add(data);
      }
    }
  });
}

}
