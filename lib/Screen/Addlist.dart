import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  String name, tuoi, phone, address, diem;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
             TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nhap name';
                    } else {
                      name = value;
                    }
                  },
                  style: TextStyle(fontSize: 20,color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: "Nhap ten",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red,width: 2),
                  ),
                ),
                ),

              SizedBox(
                height: 10,
              ),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nhap tuoi';
                    } else {
                      tuoi = value;
                    }
                  },
                  style: TextStyle(fontSize: 20,color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: "Nhap tuoi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.red,width: 2),
                    ),
                  ),
                ),

              SizedBox(
                height: 10,
              ),
             TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nhap sdt';
                    } else {
                      phone = value;
                    }
                  },
                  style: TextStyle(fontSize: 20,color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: "Nhap so dien thoai",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.red,width: 2),
                    ),
                  ),
                ),

              SizedBox(
                height: 10,
              ),
             TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nhap dia chi';
                    } else {
                      address = value;
                    }
                  },
                  style: TextStyle(fontSize: 20,color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: "Nhap dia chi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.red,width: 2),
                    ),
                  ),
                ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: upload,
              child: Center(child: Text("Them sv")),
                color: Colors.cyanAccent,
              ),

            ],
          ),
        ),
      ),
    );
  }
   Future<void> upload() async{

     if (formKey.currentState.validate()) {
       DatabaseReference databaseReference = FirebaseDatabase.instance
           .reference().child("users");
       String upload = databaseReference.push().key;
       HashMap map = new HashMap();
       map ["name"] = name;
       map ["tuoi"] = tuoi;
       map ["phone"] = phone;
       map ["address"] = address;
       databaseReference.child(upload).set(map).then((_){
         Navigator.pop(context);
       });


     }
   }
}
