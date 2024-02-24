import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:iutapp/utils/appcolor.dart';
import 'package:iutapp/widget/custome_button.dart';
// import 'package:custom_switch/custom_switch.dart';

import '../../controller/user_controller.dart';
import '../../controller/admin_controller.dart';
import '../../widget/text.dart';
import '../login_screen.dart';

class EditUser extends StatelessWidget {
  final AdminController adminController = Get.find();

  String? flag = "🇸🇦", phoneCode = "966", hintphoneExam;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AdminController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.buttonColor,
            actions: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Get.to(Profile());
                    },
                    child: Text(
                      'تعديل',
                      style: TextStyle(
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () async {
                      var x = await GetStorage().read('user');
                      GetStorage().remove('user');
                      Get.off(LoginScreen());
                    },
                  )
                ],
              ),
            ],
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * .01,
                    left: size.height * .03,
                    right: size.height * .03,
                    bottom: size.height * .01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValidateTextView(
                      enabled: true,
                      textInputType: TextInputType.text,
                      controller: controller.name,
                      hintText: 'الاسم  ',
                      msgRequired: 'يجب إدخال الاسم  ',
                      filedSize: r'^.{1,30}$',
                      onChanged: (val) {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: ValidateTextView(
                            enabled: true,
                            textInputType: TextInputType.phone,
                            controller: controller.phone,
                            hintText: 'رقم الهاتف',
                            msgRequired: 'يجب إدخال رقم الهاتف',
                            onChanged: (val) {},
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(phoneCode!),
                                Text(flag!),
                              ],
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ValidateTextView(
                            enabled: true,
                            textInputType: TextInputType.visiblePassword,
                            controller: controller.password,
                            hintText: 'كلمة المرور',
                            msgRequired: 'يجب إدخال كلمة المرور',
                            filedSize: r'^.{1,30}$',
                            onChanged: (val) {},
                          ),
                        ),
                      ],
                    ),
                    // CustomSwitch(
                    //   activeColor: Colors.pinkAccent,
                    //   value: controller.isActive,
                    //   onChanged: (value) {
                    //     controller.active = value;
                    //     controller.update();
                    //   },
                    // ),
                  ],
                ),
              ),
              CustomeButton(
                size: size * .8,
                function: () async {
                  controller.UpdateUser(controller.user['id']);
                  // controller.showDialog('df', Colors.red);
                },
                colors: AppColor.buttonColor,
                text: "تعديل الحساب",
                textStyle: TextStyle(
                    
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontWeight: FontWeight.bold),
              ),
            ],
          )));
    });
  }
}
