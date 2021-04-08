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
  bool del = false;
  String keyy;
  // final DatabaseReference reference =
  //     FirebaseDatabase.instance.reference().child("users");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("users");
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
          backgroundColor: Colors.purpleAccent,
          title: TextField(
            controller: _search,
            decoration: InputDecoration(
              hintText: "Search...",
              helperStyle: TextStyle(color: Colors.white),
              labelText: "Search",
              labelStyle: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onChanged: (text) {
              search(text);
            },
          ),
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
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
                Colors.white,
              ])),
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
                        Colors.white,
                      ])),
                  child: Center(
                    child: Text("Loading..."),
                  ),
                )
              : Container(

               padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (_, index) {
                        return Container(
                          child: CarUI(
                              dataList[index].image,
                              dataList[index].name,
                              dataList[index].tuoi,
                              dataList[index].phone,
                              dataList[index].address,
                              dataList[index].diem,
                              dataList[index].keydelete),
                        );
                      }),
                ),
        ));
  }

  Widget CarUI(String image, String name, String tuoi, String phone,
      String address, String diem, String keydelete) {
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
                image,
                fit: BoxFit.contain,
                height: 150,
                width: 150,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Tên: " + name,style:TextStyle(color: Colors.black, fontSize: 16),),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Tuổi: " + tuoi,style:TextStyle(color: Colors.black, fontSize: 16),),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Sdt: " + phone,style:TextStyle(color: Colors.black, fontSize: 16),),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Địa chỉ: " + address,style:TextStyle(color: Colors.black, fontSize: 16),),

                  SizedBox(
                    width: 10,
                  ),
                  Text("Điểm TB: " + diem,style:TextStyle(color: Colors.black, fontSize: 16),),
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
                                      builder: (context) => update(keydelete)));
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
                                keyy= keydelete ;
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

            ],
          ),
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
        reference.child(keyy).remove().then(
                (value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Viewlist()))
        );
      }
    });
  }

}
