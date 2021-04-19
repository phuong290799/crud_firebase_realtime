import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:managerstudent_getx/Controller/controller.dart';
import 'package:managerstudent_getx/Models/studentObj.dart';
import 'package:managerstudent_getx/Screen/Hompage.dart';
import 'package:managerstudent_getx/Screen/update.dart';


class ViewStudent extends StatefulWidget {

  String image,name,tuoi,phone,address,diem,keyy;
  ViewStudent({this.image,this.name,this.tuoi,this.phone,this.address,this.diem,this.keyy});

  @override
  _ViewStudentState createState() => _ViewStudentState();
}

class _ViewStudentState extends State<ViewStudent> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              border: Border.all(color: Colors.blue, width: 2),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.white,
                    Colors.blueAccent,
                  ])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                widget.image,
                fit: BoxFit.contain,
                height: 150,
                width: 150,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Tên: " + widget.name,style:TextStyle(color: Colors.black, fontSize: 16),),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Tuổi: " + widget.tuoi,style:TextStyle(color: Colors.black, fontSize: 16),),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Sdt: " + widget.phone,style:TextStyle(color: Colors.black, fontSize: 16),),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Địa chỉ: " + widget.address,style:TextStyle(color: Colors.black, fontSize: 16),),

                    SizedBox(
                      width: 10,
                    ),
                    Text("Điểm TB: " + widget.diem,style:TextStyle(color: Colors.black, fontSize: 16),),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text("Sửa:"),
                            IconButton(
                              icon: Icon(Icons.edit_outlined,size: 25,color: Colors.red,),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => update(widget.keyy)));
                              },
                            ),
                          ],
                        ),
                        // Text(diem),
                        Row(
                          children: [
                            Text("Xoá:"),
                            IconButton(
                                icon: Icon(Icons.delete,size: 25,color: Colors.red,),
                                onPressed: () {
                                  _showdialog();
                                  // delete();

                                }),
                          ],
                        ),
                      ],
                    )
                    // Text("Địa chỉ: "+address),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  // void search(String text) {
  //   DatabaseReference searchref =
  //       FirebaseDatabase.instance.reference().child("users");
  //   searchref.once().then((DataSnapshot dataSnapshot) {
  //     dataList.clear();
  //     var keys = dataSnapshot.value.keys;
  //     var values = dataSnapshot.value;
  //     for (var key in keys) {
  //       StudentObj data = new StudentObj(
  //         values[key]["image"],
  //         values[key]["name"],
  //         values[key]["tuoi"],
  //         values[key]["phone"],
  //         values[key]["address"],
  //         values[key]["diem"],
  //         key,
  //       );
  //
  //       if (data.name.contains(text)) {
  //         dataList.add(data);
  //       }
  //     }
  //   });
  // }

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
    DatabaseReference reference = FirebaseDatabase
        .instance
        .reference()
        .child("users");
    setState(() {
      {
        reference.child(widget.keyy).remove();

      }
    });
  }

}
