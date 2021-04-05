import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:managerstudent_getx/Screen/update.dart';
import 'package:managerstudent_getx/controllers/Data.dart';

class Viewlist extends StatefulWidget {
  @override
  _ViewlistState createState() => _ViewlistState();
}

class _ViewlistState extends State<Viewlist> {
  List<Data> dataList = [];


  // final DatabaseReference reference =
  //     FirebaseDatabase.instance.reference().child("users");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference reference =FirebaseDatabase.instance.reference().child("users");
    reference.once().then((DataSnapshot dataSnapshot) {
      dataList.clear();
      var keys = dataSnapshot.value.keys;
     var values = dataSnapshot.value;
      for (var key in keys) {
        print("Key : " + key);
        Data data = new Data(
          values[key]["name"],
          values[key]["tuoi"],
          values[key]["phone"],
          values[key]["address"],
          key,
          // values[key]["diem"],
        );
        dataList.add(data);
      //  print(data.key);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text("Xem thông tin sinh viên"),
        ),
        body: dataList.length == 0
            ? Container(
               height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.deepPurple,
                    Colors.lightGreen,
                  ]
                )
              ),
              child: Center(
                  child: Text("Loading..."),
                ),
            )
            : ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (_, index) {
                  return CarUI(dataList[index].name, dataList[index].tuoi,
                      dataList[index].phone, dataList[index].address,dataList[index].keydelete);

                }));
  }

  Widget CarUI(String name, String tuoi, String phone, String address, String keydelete) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple,width: 2),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.lightGreenAccent,
              Colors.amberAccent,
            ]
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Tên:"+name),
                SizedBox(width: 10,),
                Text("Tuổi: "+tuoi),
                SizedBox(width: 10,),
                Text("Số điện thoại: "+phone),
                SizedBox(width: 10,),
                Text("Địa chỉ: "+address),

              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text("Sửa"),
                    IconButton(
                      icon: Icon(Icons.edit_outlined),
                      onPressed: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => update(keydelete)));
                      },
                    ),
                  ],
                ),
                // Text(diem),
                Row(
                  children: [
                    Text("Xoá"),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){
                        DatabaseReference reference =FirebaseDatabase.instance.reference().child("users");
                        setState(() {
                          reference
                              .child(keydelete)
                              .remove()
                              .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewlist())));
                        });
                        // print(key);
                        // delete(data);
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
 // void delete(){
 //
 //  setState(() {
 //  reference
 //      .child(key)
 //      .remove()
 //      .then((value) => Navigator.pop(context));
 //  });
 //
 //   }
}

