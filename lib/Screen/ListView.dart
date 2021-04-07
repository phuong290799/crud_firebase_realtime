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
TextEditingController _search = TextEditingController();

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
          values[key]["image"],
          values[key]["name"],
          values[key]["tuoi"],
          values[key]["phone"],
          values[key]["address"],
          values[key]["diem"],
          key,
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
          title: TextField(
            controller: _search,
            decoration: InputDecoration(
              hintText: "Search...",
              helperStyle: TextStyle(color: Colors.white),
              labelText: "Search",
              labelStyle: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onChanged: (text){
              search(text);
            },
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {

                }),
          ],
        ),
        body: Container(
         // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.lightBlueAccent,
                    Colors.deepOrangeAccent,
                  ]
              )
          ),
          child: dataList.length == 0
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
              : Container(
            padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (_, index) {
                      return CarUI(dataList[index].image,dataList[index].name, dataList[index].tuoi,
                          dataList[index].phone, dataList[index].address, dataList[index].diem,dataList[index].keydelete);

                    }),
              ),
        ));
  }

  Widget CarUI(String image, String name, String tuoi, String phone, String address,String diem, String keydelete) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: Colors.yellow,width: 3),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.lightGreenAccent,
              Colors.white,
            ]
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  image,
                  fit: BoxFit.contain,
                  height: 200,
                  width: 200,
                ),
                Text("Tên:"+name),
                SizedBox(width: 10,),
                Text("Tuổi: "+tuoi),
                SizedBox(width: 10,),
                Text("Số điện thoại: "+phone),
                SizedBox(width: 10,),
                Text("Địa chỉ: "+address),

                SizedBox(width: 10,),
                Text("Điểm trung bình: "+diem),
               // Text("Địa chỉ: "+address),

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
  void search(String text) {
    DatabaseReference searchref =
    FirebaseDatabase.instance.reference().child("users");
    searchref.once().then((DataSnapshot dataSnapshot) {
      dataList.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        Data data = new Data(
          values[key]["image"],
          values[key]["name"],
          values[key]["tuoi"],
          values[key]["phone"],
          values[key]["address"],
          values[key]["diem"],
          key,
        );

        if (data.name.contains(text)) {
         dataList.add(data);
        }
      }
    });
  }
}

