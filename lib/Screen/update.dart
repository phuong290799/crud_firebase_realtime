
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:managerstudent_getx/Screen/ListView.dart';
import 'package:managerstudent_getx/controllers/Data.dart';

class update extends StatefulWidget {
  String keydelete;
  update(this.keydelete);
  @override

  _updateState createState() => _updateState(keydelete);
}

class _updateState extends State<update> {
  _updateState(this.key);
  String key;
  String name, tuoi, phone, address, diem;
  String name2, tuoi2, phone2, address2, diem2;

  final GlobalKey<FormState> keyform = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference reference =FirebaseDatabase.instance.reference().child("users").child(key);
    reference.once().then((DataSnapshot dataSnapshot) {
     // var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
       {
        print("Key : " + key);

          name= values["name"];
          tuoi= values["tuoi"];
          phone= values["phone"];
          address=values["address"];
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

      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Form(
            key: keyform,
            child: Column(
              children: [

                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nhap name';
                    } else {
                      name2 = value;
                    }
                  },
                  style: TextStyle(fontSize: 20,color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: name,
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
                      tuoi2 = value;
                    }
                  },
                  style: TextStyle(fontSize: 20,color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: tuoi,
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
                      phone2 = value;
                    }
                  },
                  style: TextStyle(fontSize: 20,color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: phone,
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

                      address = value;
                     return 'Nhap dia chi';
                    } else {
                      address2 = value;
                    }
                  },
                  style: TextStyle(fontSize: 20,color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: address,
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
                  onPressed: update2,
                  child: Center(child: Text("Cap nhat")),
                  color: Colors.cyanAccent,
                ),

              ],
            ),
          ),
        ),
    );
  }
  Future<void> update2() async{


     if (keyform.currentState.validate()) {
      DatabaseReference databaseReference = FirebaseDatabase.instance
          .reference().child("users");
      Map<String, String> map = {
        'name': name2,
        'tuoi':  tuoi2,
        'phone': phone2,
        "address": address2
      };

      databaseReference.child(key).update(map).then((_){
       Navigator.push(context, MaterialPageRoute(builder: (context) => Viewlist(),));
      });
   }
  }

  }
