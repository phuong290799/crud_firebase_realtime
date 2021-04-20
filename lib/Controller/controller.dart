import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:managerstudent_getx/Models/studentObj.dart';

class Controller extends GetxController{
  final List<StudentObj> dataList = [];

 ReadStudent(){
   final List<StudentObj> dataList = [];
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
   });

 }////no



}