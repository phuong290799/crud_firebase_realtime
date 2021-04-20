import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:managerstudent_getx/Controller/controller.dart';
import 'package:managerstudent_getx/Models/studentObj.dart';
import 'package:managerstudent_getx/Screen/Hompage.dart';
import 'package:managerstudent_getx/Screen/update.dart';
import 'package:managerstudent_getx/Theme/colors.dart';
import 'package:managerstudent_getx/Theme/style.dart';

class ViewStudent extends StatefulWidget {
  String image, name, tuoi, phone, address, gioithieu, keyy;
  ViewStudent(
      {this.image,
      this.name,
      this.tuoi,
      this.phone,
      this.address,
      this.gioithieu,
      this.keyy});

  @override
  _ViewStudentState createState() => _ViewStudentState();
}

class _ViewStudentState extends State<ViewStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 50,
                width: 50,
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.coloricon,
                ),
                decoration: BoxDecoration(
                    color: AppColors.BACKGROUND,
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
            Text(widget.name, style: AppThemes.Text20Medium),
            SizedBox(
              width: 50,
            ),
          ],
        ),
        backgroundColor: AppColors.Scaffor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.image,
                fit: BoxFit.contain,
                height: 150,
                width: 150,
              ),
              SizedBox(height: 20,),
              Text(
                "Tên: " + widget.name,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                "Tuổi: " + widget.tuoi,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),

              Text(
                "Sdt: " + widget.phone,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),

              Text(
                "Địa chỉ: " + widget.address,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),

              SizedBox(
                width: 10,
              ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Text(
              "Giới thiệu:",
              style: AppThemes.Text18,
            ),
          ),
          Container(
              height: 200,
              child: Text(
                widget.gioithieu,
                style: TextStyle(color: Colors.black, fontSize: 16),
              )),
          Container(
            child: Row(
              children: [
                Text("Sửa:"),
                IconButton(
                  icon: Icon(
                    Icons.edit_outlined,
                    size: 25,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => update(widget.keyy)));
                  },
                ),
                // Text(gioithieu),
                Text("Xoá:"),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 25,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _showdialog();
                      // delete();
                    }),
              ],
            ),
          ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showdialog() {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Bạn có muốn xoá?"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            content: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        delete();
                        Get.to(MyHomePage());
                      },
                      child: Text("Có")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Không")),
                ],
              ),
            ),
          );
        });
  }

  void delete() {
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("users");
    setState(() {
      {
        reference.child(widget.keyy).remove();
      }
    });
  }
}
