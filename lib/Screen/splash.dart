import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:managerstudent_getx/Screen/Hompage.dart';
import 'package:managerstudent_getx/Screen/Login.dart';
import 'package:managerstudent_getx/Theme/colors.dart';
import 'package:managerstudent_getx/Theme/style.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.BACKGROUND,
        child: Column(
          children: [
            SizedBox(height: 250,),
            Container(
              child: Text("Chào mừng bạn đến với ứng dụng",style: AppThemes.Text20,),
            ),
            Text("Quản lý sinh viên",style: TextStyle(fontSize: 25,color: Colors.black,fontFamily:'Roboto_Bold'),),
            Image.asset("assets/images/sv2.png",height: 200,width: 250,),
            Text("Bạn đã có tài khoản ?"),
            TextButton(onPressed: (){
              Get.to(()=>Login());
            }, child: Text("Đăng nhập để quản lý",style: TextStyle(fontSize: 20),)),
            Text("Hoặc"),
            TextButton(onPressed: (){
              Get.to(()=>MyHomePage());
            }, child: Text("Sử dụng với tư cách khách",style: TextStyle(fontSize: 20),)),


          ],
        ),
      ),
    );
  }
}
