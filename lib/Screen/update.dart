import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:managerstudent_getx/Screen/Hompage.dart';
import 'package:managerstudent_getx/Screen/viewStudent.dart';
import 'package:managerstudent_getx/Theme/colors.dart';
import 'package:managerstudent_getx/Theme/style.dart';

class update extends StatefulWidget {
  String keydelete;

  update(this.keydelete);
  @override
  _updateState createState() => _updateState(keydelete);
}

class _updateState extends State<update> {
  _updateState(this.key);
  bool pic= true;
  final picker = ImagePicker();
  File image2;
  String key;
  String urlImage2;
  String urlimage, name, tuoi, phone, address, gioithieu;
  String name2, tuoi2, phone2, address2, gioithieu2;
  final GlobalKey<FormState> keyform = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("users").child(key);
    reference.once().then((DataSnapshot dataSnapshot) {
      // var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      {
        print("Key : " + key);
        urlimage = values["image"];
        name = values["name"];
        tuoi = values["tuoi"];
        phone = values["phone"];
        address = values["address"];
        gioithieu = values["gioithieu"];
        key;
        // values[key]["gioithieu"],

        //  print(data.key);
      }

      setState(() {});
    });
  }

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
            Text("Update", style: AppThemes.Text20Medium),
            SizedBox(
              width: 50,
            ),
          ],
        ),
        backgroundColor: AppColors.Scaffor,
      ),
      body: Container(

        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Column(
            children: [
              Container(
                  child: urlimage != null
                      ? Container(
                          child: image2 == null
                              ? Row(
                                  children: [
                                    Image.network(
                                      urlimage,
                                      fit: BoxFit.contain,
                                      height: 200,
                                      width: 200,
                                    ),
                                    FlatButton(
                                        onPressed: () {
                                          _showDialog();
                                          pic=false;
                                        },
                                        child: Row(
                                          children: [
                                            Text("Đổi ảnh:"),
                                            Icon(
                                              Icons.add_a_photo,
                                              color: Colors.black,
                                              size: 50,
                                            ),
                                          ],
                                        ))
                                  ],
                                )
                              : Image.file(
                                  image2,
                                  height: 200,
                                  width: 200,
                                ),
                        )
                      : null),
              SizedBox(
                height: 20,
              ),
              Form(
                key: keyform,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          name2= name;
                        } else {
                          name2 = value;
                        }
                      },
                      style: AppThemes.Text14,
                      decoration: InputDecoration(
                        labelText: "Họ tên: $name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          tuoi2= tuoi;
                        } else {
                          tuoi2 = value;
                        }
                      },
                      style: AppThemes.Text14,
                      decoration: InputDecoration(
                        labelText: "Tuổi: $tuoi",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          phone2=phone;
                        } else {
                          phone2 = value;
                        }
                      },
                      style: AppThemes.Text14,
                      decoration: InputDecoration(
                        labelText: 'Số điện thoại: $phone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          address2=address;
                        } else {
                          address2 = value;
                        }
                      },
                      style: AppThemes.Text14,
                      decoration: InputDecoration(
                        labelText: "Địa chỉ: $address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Giới thiệu",style: AppThemes.Text18,),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            gioithieu2="Vui tính" ;
                          } else {
                            gioithieu2 = value;
                          }
                        },
                        style: AppThemes.Text14,
                        decoration: InputDecoration(
                          labelText: "Giới thiệu: $gioithieu",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 150,
                      child: RaisedButton(
                        onPressed: () {
                          update2();
                          Get.to(()=>MyHomePage());
                        },
                        child: Center(child: Text("Cap nhat")),
                        color: Colors.cyanAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> update2() async {
    if (keyform.currentState.validate()) {
      //print(urlImage2);
     // print(urlImage2 = urlimage);


      DatabaseReference databaseReference =
          FirebaseDatabase.instance.reference().child("users");
      if(pic==false){
      Reference _refrence = FirebaseStorage.instance.ref().child("users").child(
          new DateTime.now().microsecondsSinceEpoch.toString() +
              "." + image2.path);
      UploadTask uploadTask = _refrence.putFile(image2);
      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      urlImage2 = imageUrl.toString();}
        else{
      urlImage2=urlimage;}



      Map<String, String> map = {
        'image': urlImage2,
        'name': name2,
        'tuoi': tuoi2,
        'phone': phone2,
        "address": address2,
        'gioithieu': gioithieu2,
      };

      databaseReference.child(key).update(map).then((_) {

      });
    }
  }

  Future<void> _showDialog() {
    return showDialog(
        context: context,
        builder: (Buildcontext) {
          return AlertDialog(
              title: Text("Chọn ảnh"),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Mở tệp"),
                    onTap: () {
                      openGallary();
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      opencamera();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> opencamera() async {
    var picture = await picker.getImage(source: ImageSource.camera);
    this.setState(() {
      if (picture != null) {
        image2 = File(picture.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> openGallary() async {
    var picture = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      if (picture != null) {
        image2 = File(picture.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
