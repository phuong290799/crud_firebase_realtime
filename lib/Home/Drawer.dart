import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:managerstudent_getx/Controller/controller.dart';
import 'package:managerstudent_getx/Screen/Addlist.dart';
import 'package:managerstudent_getx/Screen/Hompage.dart';
import 'package:managerstudent_getx/Screen/Login.dart';
import 'package:managerstudent_getx/Screen/splash.dart';
import 'package:managerstudent_getx/Theme/colors.dart';
import 'package:managerstudent_getx/Theme/style.dart';

class OpenDrawer extends StatelessWidget {


  Controller controllerDrawer = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColors.BACKGROUND,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 70,height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset("assets/images/admin.png"),

                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Admin",
                      style: AppThemes.Text16Medium,
                    ),
                    Text(
                      "phuong@.com",
                      style: AppThemes.Text14Medium,
                    ),
                  ],
                ),
              )),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.home),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "My Home",
                  style: AppThemes.Text16,
                )
              ],
            ),
            onTap: () {Get.to(MyHomePage());},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.post_add_outlined),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Add Student",
                  style: AppThemes.Text16,
                )
              ],
            ),
            onTap: () {
              if(controllerDrawer.IsLogin){
                print("login");
                print(controllerDrawer.IsLogin);
                Get.to(()=>Add());
              }else{
                  return showDialog(
                      context: context,
                      builder: (BuildContext) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text("     Bạn phải đăng nhập trước!\nBạn có muốn quay lại trang login",style: AppThemes.Text16Medium,),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          content: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Get.off(Login());
                                    },
                                    child: Text("Có")),
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Không")),
                              ],
                            ),
                          ),
                        );
                      });
              }
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.connect_without_contact),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Contact Us",
                  style: AppThemes.Text16,
                )
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.settings),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Setting",
                  style: AppThemes.Text16,
                )
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.exit_to_app),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Sign Out",
                  style: AppThemes.Text16,
                )
              ],
            ),
            onTap: () {
              controllerDrawer.IsLogin = false;
              Get.off(()=>Splash());},
          ),
        ],
      ),
    );
  }
}
