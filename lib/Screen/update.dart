import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:managerstudent_getx/Screen/ListView.dart';

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
  String urlimage, name, tuoi, phone, address, diem;
  String name2, tuoi2, phone2, address2, diem2;
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
        diem = values["diem"];
        key;
        // values[key]["diem"],

        //  print(data.key);
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text("Cập nhật"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.lightBlueAccent,
                  Colors.white,
                ])),
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
                          name2 = name;
                        } else {
                          name2 = value;
                        }
                      },
                      style: TextStyle(fontSize: 20, color: Colors.amber),
                      decoration: InputDecoration(
                        hintText: "Nhập tên",
                        labelText: name,
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
                          tuoi2 = tuoi;
                        } else {
                          tuoi2 = value;
                        }
                      },
                      style: TextStyle(fontSize: 20, color: Colors.amber),
                      decoration: InputDecoration(
                        hintText: "Nhập tuổi",
                        labelText: tuoi,
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
                          phone2 = phone;
                        } else {
                          phone2 = value;
                        }
                      },
                      style: TextStyle(fontSize: 20, color: Colors.amber),
                      decoration: InputDecoration(
                        hintText: "Nhập số điện thoại",
                        labelText: phone,
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
                          // address = value;
                          address2 = address;
                        } else {
                          address2 = value;
                        }
                      },
                      style: TextStyle(fontSize: 20, color: Colors.amber),
                      decoration: InputDecoration(
                        hintText: "Nhập địa chỉ",
                        labelText: address,
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
                          // diem = value;
                          diem2 = diem;
                        } else {
                          diem2 = value;
                        }
                      },
                      style: TextStyle(fontSize: 20, color: Colors.amber),
                      decoration: InputDecoration(
                        hintText: "Nhập điểm trung bình",
                        labelText: diem,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 30,
                      width: 150,
                      child: RaisedButton(
                        onPressed: () {
                          update2();
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
              "." +
              image2.path);
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
        'diem': diem2,
      };

      databaseReference.child(key).update(map).then((_) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Viewlist(),
            ));
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
