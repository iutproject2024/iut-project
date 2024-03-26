import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:iutapp/widget/custome_button.dart';
import '../../controller/scroll_controller.dart';
import '../../widget/user_card.dart';
import '../../controller/admin_controller.dart';
import '../../utils/appcolor.dart';

class UserList extends StatelessWidget {
  final AdminController adminController = Get.find();
  final ScrollToTopController sController = Get.put(ScrollToTopController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AdminController>(builder: (controller) {
      return Scaffold(
          body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                  top: size.width * .03,
                  left: size.width * .15,
                  right: size.width * .15,
                  bottom: size.width * .03),
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                hint: const Center(
                  child: Text(
                    'حدد مجموعة المستخدمين',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: controller.userListItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Center(
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.changeType(value!);
                  controller.getData(controller.userType);
                  controller.update();
                },
              ),
            ),
          ),
          Expanded(
              flex: 9,
              child: controller.userList.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      controller: sController.msgScroll,
                      itemCount: controller.userList.length,
                      itemBuilder: (context, i) {
                        final item = controller.userList![i];

                        return UserCard(size, item, context, controller);
                      },
                    )
                  : Center(
                      child: CustomeButton(
                        text: "لا يوجد أي مستخدمين",
                        function: () {},
                        colors: AppColor.buttonColor,
                        size: size * .8,
                        textStyle: TextStyle(
                            color: AppColor.textColor,
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold),
                      ),
                    )),
        ],
      ));
    });
  }
}
