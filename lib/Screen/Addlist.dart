import 'dart:collection';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:managerstudent_getx/Screen/ListView.dart';

class Add extends StatefulWidget {
  final File image;
  Add({Key key, @required this.image}) : super(key: key);
  @override
  _AddState createState() => _AddState(image);
}

class _AddState extends State<Add> {
  File _image;
  final picker = ImagePicker();
  String name, tuoi, phone, address, diem;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  _AddState(this._image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""
            "Thêm sinh viên",style: TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.lightGreenAccent,
              Colors.white,
            ])),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  child: _image == null
                      ? FlatButton(
                          onPressed: () {
                            _showDialog();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("                      Thêm ảnh"),
                              Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black,
                                  size: 50,
                                ),
                              ),
                            ],
                          ))
                      : Image.file(
                          _image,
                          height: 200,
                          width: 200,
                        ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nhập tên';
                    } else {
                      name = value;
                    }
                  },
                  style: TextStyle(fontSize: 20, color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: "Nhập tên",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nhập tuổi';
                    } else {
                      tuoi = value;
                    }
                  },
                  style: TextStyle(fontSize: 20, color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: "Nhập tuổi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nhập số điện thoại';
                    } else {
                      phone = value;
                    }
                  },
                  style: TextStyle(fontSize: 20, color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: "Nhập số điện thoại",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nhập địa chỉ';
                    } else {
                      address = value;
                    }
                  },
                  style: TextStyle(fontSize: 20, color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: "Nhập địa chỉ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Điểm';
                    } else {
                      diem = value;
                    }
                  },
                  style: TextStyle(fontSize: 20, color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: "Nhập điểm",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      side: BorderSide(color: Colors.white, width: 2)),
                  onPressed: () {
                    if (_image == null) {
                      Fluttertoast.showToast(
                          msg: "chọn ảnh",
                          gravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_LONG,
                          timeInSecForIosWeb: 3);
                    } else {
                      upload();
                    }
                  },
                  child: Center(child: Text("Thêm sinh viên")),
                  color: Colors.cyanAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> upload() async {
    if (formKey.currentState.validate()) {

      DatabaseReference databaseReference =
          FirebaseDatabase.instance.reference().child("users");
      Reference _refrence = FirebaseStorage.instance.ref().child("users").child(
          new DateTime.now().microsecondsSinceEpoch.toString() +
              "." +
              _image.path);
      UploadTask uploadTask = _refrence.putFile(_image);
      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      String _url = imageUrl.toString();
      String upload = databaseReference.push().key;
      HashMap map = new HashMap();
      map["image"] = _url;
      map["name"] = name;
      map["tuoi"] = tuoi;
      map["phone"] = phone;
      map["address"] = address;
      map["diem"] = diem;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Viewlist(),));
      databaseReference.child(upload).set(map).then((_) {

      });
    }
  }

  Future<void> _showDialog() {
    return showDialog(
        context: context,
        builder: (Buildcontext) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Chọn ảnh"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Chọn trong tệp"),
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
        _image = File(picture.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> openGallary() async {
    var picture = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      if (picture != null) {
        _image = File(picture.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
