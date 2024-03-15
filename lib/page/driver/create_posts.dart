import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iutapp/controller/student_controller.dart';

import '../../controller/driver_controller.dart';
import '../../utils/appcolor.dart';
import '../../widget/custome_button.dart';

class CreatePost extends StatelessWidget {
  final DriverController driverController = Get.find();
  final StudentController studentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.only(right: 2, left: 2),
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
                width: 1.0, style: BorderStyle.solid, color: Colors.blueGrey),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          color: Colors.white.withOpacity(0.8),
        ),
        child: Column(
          children: [
            SizedBox(height: 5),
            CustomeButton(
              text: "إضافة خبر",
              function: () {},
               colors: AppColor.buttonColor,
                              size: MediaQuery.of(context).size * .8,
                              textStyle: TextStyle(
                                  color: AppColor.textColor,
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  fontWeight: FontWeight.bold),
            ),
              SizedBox(height: 5), TextFormField(
              controller: controller.posttext,
              maxLength: 1000,
              maxLines: 10,
              minLines: 1,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(right: 10, bottom: 10, top: 3, left: 5),
                  hintText: "مــنــشــور جــــديـــد .....",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15))),
            ),

            SizedBox(height: 5),

            Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              height: 100,
              width: MediaQuery.of(context).size.width - 5,
              child: Center(
                child: controller.visblimgon
                    ? InkWell(
                        child: controller.img != null
                            ? Container(
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color:
                                            Colors.greenAccent.withOpacity(0.5),
                                        blurRadius: 8),
                                  ],
                                ),
                                height: 90,
                                width: 80,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  child: Hero(
                                    tag: controller.img!,
                                    child: Image.file(controller.img!,
                                        fit: BoxFit.fill),
                                  ),
                                ))
                            : Row(),
                        onTap: () async {
                          Get.defaultDialog(
                              title: "حذف",
                              middleText: "هل تريد حذف الصورة ",
                              middleTextStyle: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              backgroundColor: Colors.white,
                              titleStyle: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      // setState(() {
                                      controller.visblimgon = false;
                                      controller.update();
                                      // });
                                    },
                                    child: Text(
                                      'نعم',
                                      style: TextStyle(
                                          fontFamily: ArabicFonts.Cairo,
                                          package: 'google_fonts_arabic',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'لا',
                                      style: TextStyle(
                                          fontFamily: ArabicFonts.Cairo,
                                          package: 'google_fonts_arabic',
                                          fontSize: 16,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                              radius: 30);
                        })
                    : SizedBox(width: 3),
              ),
            ),

            const Divider(height: 10.0, thickness: 0.5),

            Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      controller.getImage(ImageSource.camera);
                    },
                    icon: const Icon(
                      Icons.camera_enhance,
                      color: Colors.red,
                      size: 20,
                    ),
                    label: Text('الـكـاميرا'),
                  ),
                  const VerticalDivider(width: 8.0),
                  TextButton.icon(
                    onPressed: () {
                      controller.getImage(ImageSource.gallery);
                    },
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.green,
                      size: 20,
                    ),
                    label: Text('معرض الصور'),
                  ),
                  const VerticalDivider(width: 8.0),
                  TextButton.icon(
                    onPressed: () {
                      controller.addPost();
                      studentController.getPosts(1);
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.green,
                      size: 30,
                    ),
                    label: Text(
                      'حفظ',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  //  CustomeButton(
                  //   text: "حفظ ",
                  //   function: () {
                  //     controller.addPost();
                  //   },
                  //   // colors: AppColor.buttonColor,
                  //   size: MediaQuery.of(context).size * .5,
                  //   textStyle: TextStyle(
                  //       color: AppColor.buttonColor,
                  //       fontFamily: ArabicFonts.Cairo,
                  //       package: 'google_fonts_arabic',
                  //       fontWeight: FontWeight.bold),
                  // ),
                ],
              ),
            ),

            //
          ],
        ),
      );
    });
  }
  
}
