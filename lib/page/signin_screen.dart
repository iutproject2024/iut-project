import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:iutapp/widget/custome_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:cr_calendar/src/cr_calendar.dart';

import '../controller/admin_controller.dart';
import '../utils/appcolor.dart';
import '../widget/text.dart';

class SignInScreen extends StatelessWidget {
  final AdminController adminController = Get.find();
  CrCalendarController _controller = CrCalendarController();

  String? flag = "🇸🇦", phoneCode = "966", hintphoneExam = 'رقم الهاتف';
  void changeCountry(Country country) {
    country = country;
    flag = country.flagEmoji;
    phoneCode = country.phoneCode;
    hintphoneExam = country.fullExampleWithPlusSign;
  }

  var userTypes = [
    'سائق',
    'طالب',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var user = GetStorage().read('user');

    return GetBuilder<AdminController>(builder: (controller) {
      return Scaffold(
          // backgroundColor: Colors.blue[200],
          body: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 1,
              itemBuilder: (context, i) {
                return
                    // GetBuilder<UserController>(
                    //     builder: (controller) =>
                    Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    user.toString().length == 0
                        ? Center(
                            child: Image.asset(
                              'assets/back1.jpg',
                              width: size.width * .8,
                              height: size.height * .3,
                            ),
                          )
                        : Row(),
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
                          DropdownButtonFormField2(
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
                                'نوع الحساب',
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
                            buttonPadding:
                                const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            items: userTypes
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
                            validator: (value) {
                              if (value == null) {
                                return 'الرجاء تحديد نوع الحساب';
                              }
                            },
                            onChanged: (value) {
                              controller.changeType(value!);
                            },
                          ),
                          ValidateTextView(
                            enabled: true,
                            textInputType: TextInputType.text,
                            controller: controller.name,
                            hintText: 'الاسم',
                            msgRequired: 'يجب إدخال قيمة للحقل',
                            filedSize: r'^.{1,30}$',
                            onChanged: (val) {},
                          ),
                          ValidateTextView(
                            obscureText: false,
                            enabled: true,
                            textInputType: TextInputType.emailAddress,
                            controller: controller.email,
                            hintText: 'البريد الالكتروني',
                            msgRequired: 'يجب إدخال البريد الالكتروني',
                            onChanged: (val) {},
                          ),
                          ValidateTextView(
                            enabled: true,
                            textInputType: TextInputType.visiblePassword,
                            controller: controller.password,
                            hintText: 'كلمة المرور',
                            msgRequired: 'يجب إدخال قيمة للحقل',
                            // filedSize: r'^.{1,30}$',
                            onChanged: (val) {},
                          ),
                            ValidateTextView(
                                  obscureText: false,
                                  enabled: true,
                                  textInputType: TextInputType.emailAddress,
                                  controller: controller.id,
                                  hintText: 'الرقم  ',
                                  msgRequired: 'يجب إدخال الرقم    ',
                                  onChanged: (val) {},
                                )
                             ,
                          controller.userType == 3
                              ? ValidateTextView(
                                  obscureText: false,
                                  enabled: true,
                                  textInputType: TextInputType.emailAddress,
                                  controller: controller.address,
                                  hintText: 'العنوان',
                                  msgRequired: 'يجب إدخال العنوان ',
                                  onChanged: (val) {},
                                )
                              : Row(),
                          TextButton(
                              onPressed: () {
                                showCountryPicker(
                                  context: context,
                                  exclude: <String>['SA', 'EG'],
                                  favorite: <String>['SA'],
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    changeCountry(country);
                                  },
                                  countryListTheme: const CountryListThemeData(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0),
                                    ),
                                    inputDecoration: InputDecoration(
                                      labelText: 'بحث',
                                      hintText: 'انقر',
                                      prefixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            // color: const Color(0xFF8C98A8)
                                            // .withOpacity(0.2),
                                            ),
                                      ),
                                    ),
                                    searchTextStyle: TextStyle(
                                      // color: Colors.blue,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.phone,
                                      style: TextStyle(
                                          fontFamily: ArabicFonts.Katibeh,
                                          package: 'google_fonts_arabic',
                                          // color: context.theme.hintColor,
                                          fontSize: 16,
                                          height: .9),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          labelText: hintphoneExam,
                                          hintText: hintphoneExam),
                                      controller: controller.phone,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            phoneCode!,
                                            style: TextStyle(
                                                color: AppColor.buttonColor),
                                          ),
                                          Text(flag!),
                                        ],
                                      )),
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    CustomeButton(
                      size: size * .8,
                      function: () {
                        controller.signin();
                      },
                      text: 'حفظ',
                      colors: AppColor.buttonColor,
                      textStyle: TextStyle(
                          color: AppColor.textColor,
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
                    // )
                    ;
              }));
    });
  }
}
