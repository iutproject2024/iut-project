import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:iutapp/widget/custome_button.dart';
import '../../controller/driver_controller.dart';
import '../../controller/scroll_controller.dart';
import '../../widget/student_card.dart';
import '../../utils/appcolor.dart';

class StudentList extends StatelessWidget {
  final DriverController driverController = Get.find();
  final ScrollToTopController sController = Get.put(ScrollToTopController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<DriverController>(builder: (controller) {
      return Scaffold(
          body: Column(children: [
        controller.studentlist.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                controller: sController.msgScroll,
                itemCount: controller.studentlist.length,
                itemBuilder: (context, i) {
                  final item = controller.studentlist![i];
                  return StudentCard(size, item, context, controller);
                },
              )
            : Center(
                child: CustomeButton(
                text: "لا يوجد أي طلاب",
                function: () {
                  controller.getUsers();
                },
                colors: AppColor.buttonColor,
                size: size * .8,
                textStyle: TextStyle(
                    color: AppColor.textColor,
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontWeight: FontWeight.bold),
              ))
      ]));
    });
  }
}
