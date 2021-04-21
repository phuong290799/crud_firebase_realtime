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
  Controller _controllerHome= Get.put(Controller());
  final List<StudentObj> dataList = [];
  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance
        .reference()
        .child("users")
        .once()
        .then((DataSnapshot dataSnapshot) {
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
          values[key]["gioithieu"],
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
        elevation: 0.5,
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
            onTap: () {},
            child: Image.asset(
              'assets/images/admin.png',
              height: 35,
              width: 35,
            ),
          ),
          SizedBox(
            width: 20,
          ),
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
                    color: AppColors.Scaffor,
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
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
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
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
       //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20,),
                child: Center(
                  child: Text(
                    "Danh sách sinh viên",
                    style: AppThemes.Text20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: 400,
                child: dataList.length == 0
                    ? Container(
                        child: Center(
                          child: Text("Loading..."),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(left:5,right: 5),
                        decoration: BoxDecoration(
                            color: AppColors.Scaffor,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                offset: Offset(4, 8),
                                color: AppColors.gray,
                              )
                            ]),
                        child: ListView.builder(
                            itemCount: dataList.length,
                            itemBuilder: (context, index) {
                              return CardStudent(
                                  image: dataList[index].image,
                                  name: dataList[index].name,
                                  tuoi: dataList[index].tuoi,
                                  phone: dataList[index].phone,
                                  address: dataList[index].address,
                                  gioithieu: dataList[index].gioithieu,
                                  keyy: dataList[index].key);
                            }),
                      ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 50,right: 50),
                child: RaisedButton(
                  onPressed: () {
                    if(_controllerhome.IsLogin){
                    print("login");
                    print(_controllerhome.IsLogin);
                    Get.to(()=>Add());
                  }else{
                      showdialoglogin();
                    }
                    },
                  color: AppColors.BACKGROUND,
                  child: Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        "Thêm sinh viên",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  shape: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: AppColors.BACKGROUND,width: 1)
                    ),
                  ),
                ),

            ],
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
          values[key]["gioithieu"],
          key,
        );

        if (data.name.contains(text)) {
          dataList.add(data);
        }
      }
    });
  }
  Future<void> showdialoglogin() {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("     Bạn phải đăng nhập trước!\nBạn có muốn quay lại trang login",style: AppThemes.Text16Medium,),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            content: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.off(Login());
                      },
                      child: Text("Có")),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Không")),
                ],
              ),
            ),
          );
        });
  }
}
