import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:managerstudent_getx/Screen/viewStudent.dart';
class CardStudent extends StatefulWidget {
  String image,name,tuoi,phone,address,diem,keyy;
  CardStudent({this.image,this.name,this.tuoi,this.phone,this.address,this.diem,this.keyy});

  @override
  _CardStudentState createState() => _CardStudentState();
}

class _CardStudentState extends State<CardStudent> {
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
          child: GestureDetector(
            onTap: (){
              Get.to(()=> ViewStudent(image:widget.image,name:widget.name,tuoi:widget.tuoi,address:widget.address,phone:widget.phone,diem:widget.diem,keyy: widget.keyy));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
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

                      ],
                    )
                    // Text("Địa chỉ: "+address),
                  ],
                ),
          ),

          ),
        ),
    );
  }
}
