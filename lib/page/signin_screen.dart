import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:iutapp/widget/custome_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:cr_calendar/src/cr_calendar.dart';

import '../widget/text.dart';

class SignInScreen extends StatelessWidget {
  // final controller = Get.put(UserController());
  CrCalendarController _controller = CrCalendarController();

  String? flag = "🇸🇦", phoneCode = "966", hintphoneExam;
  void changeCountry(Country country) {
    country = country;
    flag = country.flagEmoji;
    phoneCode = country.phoneCode;
    hintphoneExam = country.fullExampleWithPlusSign;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                  // Container(
                  //   height: size.height * .3,
                  //   alignment: Alignment.bottomCenter,
                  //   decoration: const BoxDecoration(
                  //       image: DecorationImage(
                  //           image: AssetImage(
                  //               'assets/images/background.png'),
                  //           fit: BoxFit.fill)),
                  //   child: Container(
                  //     color: Colors.white.withOpacity(0.8),
                  //     child: DropdownButtonFormField2(
                  //       decoration: InputDecoration(
                  //         isDense: true,
                  //         contentPadding: EdgeInsets.zero,
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(15),
                  //         ),
                  //       ),
                  //       isExpanded: true,
                  //       hint: const Center(
                  //         child: Text(
                  //           'نوع الحساب',
                  //           style: TextStyle(
                  //               fontSize: 14,
                  //               fontFamily: ArabicFonts.Cairo,
                  //               package: 'google_fonts_arabic',
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //       icon: const Icon(
                  //         Icons.arrow_drop_down,
                  //         color: Colors.black45,
                  //       ),
                  //       iconSize: 30,
                  //       buttonHeight: 60,
                  //       buttonPadding:
                  //           const EdgeInsets.only(left: 20, right: 10),
                  //       dropdownDecoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(15),
                  //       ),
                  //       items: controller.userItems
                  //           .map((item) => DropdownMenuItem<String>(
                  //                 value: item,
                  //                 child: Center(
                  //                   child: Text(
                  //                     item,
                  //                     style: const TextStyle(
                  //                         fontSize: 14,
                  //                         fontFamily: ArabicFonts.Cairo,
                  //                         package:
                  //                             'google_fonts_arabic',
                  //                         fontWeight: FontWeight.bold),
                  //                   ),
                  //                 ),
                  //               ))
                  //           .toList(),
                  //       validator: (value) {
                  //         if (value == null) {
                  //           return 'الرجاء تحديد نوع الحساب';
                  //         }
                  //       },
                  //       onChanged: (value) {
                  //         controller.changeType(value!);
                  //       },
                  //       onSaved: (value) {
                  //         // selectedValue = value.toString();
                  //       },
                  //     ),
                  //   ),
                  // ),
                  Center(
                    child: Image.asset(
                      'assets/icon.png',
                      width: size.width * .8,
                      height: size.height * .3,
                    ),
                  ),
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
                        // DropdownButtonFormField2(
                        //   decoration: InputDecoration(
                        //     isDense: true,
                        //     contentPadding: EdgeInsets.zero,
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(15),
                        //     ),
                        //   ),
                        //   isExpanded: true,
                        //   hint: const Center(
                        //     child: Text(
                        //       'نوع الحساب',
                        //       style: TextStyle(
                        //           fontSize: 14,
                        //           fontFamily: ArabicFonts.Cairo,
                        //           package: 'google_fonts_arabic',
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ),
                        //   icon: const Icon(
                        //     Icons.arrow_drop_down,
                        //     color: Colors.black45,
                        //   ),
                        //   iconSize: 30,
                        //   buttonHeight: 60,
                        //   buttonPadding:
                        //       const EdgeInsets.only(left: 20, right: 10),
                        //   dropdownDecoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15),
                        //   ),
                        //   items: controller.userItems
                        //       .map((item) => DropdownMenuItem<String>(
                        //             value: item,
                        //             child: Center(
                        //               child: Text(
                        //                 item,
                        //                 style: const TextStyle(
                        //                     fontSize: 14,
                        //                     fontFamily: ArabicFonts.Cairo,
                        //                     package: 'google_fonts_arabic',
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //             ),
                        //           ))
                        //       .toList(),
                        //   validator: (value) {
                        //     if (value == null) {
                        //       return 'الرجاء تحديد نوع الحساب';
                        //     }
                        //   },
                        //   onChanged: (value) {
                        //     controller.changeType(value!);
                        //   },
                        // ),
                        ValidateTextView(
                          enabled: true,
                          textInputType: TextInputType.text,
                          // controller: controller.name,
                          hintText: 'الاسم الاول',
                          msgRequired: 'يجب إدخال الاسم الاول',
                          filedSize: r'^.{1,30}$',
                          onChanged: (val) {},
                        ),
                        ValidateTextView(
                          enabled: true,
                          textInputType: TextInputType.text,
                          // controller: controller.username,
                          hintText: 'الاسم الثاني',
                          msgRequired: 'يجب إدخال الاسم الثاني',
                          // filedSize: r'^.{1,30}$',
                          onChanged: (val) {},
                        ),
                        ValidateTextView(
                          enabled: true,
                          textInputType: TextInputType.text,
                          // controller: controller.username,
                          hintText: 'الاسم الثالث',
                          msgRequired: 'يجب إدخال الاسم الثالث',
                          // filedSize: r'^.{1,30}$',
                          onChanged: (val) {},
                        ),
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
                                countryListTheme: CountryListThemeData(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                  inputDecoration: InputDecoration(
                                    labelText: 'بحث',
                                    hintText: 'أنقر للكتابة',
                                    prefixIcon: const Icon(Icons.search),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                        fontFamily: ArabicFonts.Katibeh,
                                        package: 'google_fonts_arabic',
                                        color: context.theme.hintColor,
                                        fontSize: 16,
                                        height: .9),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        labelText: hintphoneExam,
                                        hintText: hintphoneExam),
                                    // controller: controller
                                    //     .phoneNumberController,
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(phoneCode!),
                                        Text(flag!),
                                      ],
                                    )),
                              ],
                            )),
                        // ValidateTextView(
                        //   enabled: true,
                        //   textInputType: TextInputType.number,
                        //   hintText: 'رقم الفريق',
                        // ),
                        // SizedBox(
                        //   height: size.height * .2,
                        //   width: size.width * .6,
                        //   child: CrCalendar(
                        //     initialDate: DateTime.now(),
                        //     controller: _controller,
                        //   ),
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       flex: 2,
                        //       child: ValidateTextView(
                        //         enabled: true,
                        //         textInputType: TextInputType.visiblePassword,
                        //         // controller: controller.password,
                        //         hintText: 'كلمة المرور',
                        //         msgRequired: 'يجب إدخال كلمة المرور',
                        //         filedSize: r'^.{1,30}$',
                        //         onChanged: (val) {
                        //           // controller.name = val;
                        //         },
                        //       ),
                        //     ),
                        //     Expanded(
                        //       flex: 2,
                        //       child: ValidateTextView(
                        //         enabled: true,
                        //         textInputType: TextInputType.visiblePassword,
                        //         // controller: controller.Confpassword,
                        //         hintText: 'تاكيد كلمة المرور',
                        //         msgRequired: 'يجب إدخال تاكيد  كلمة المرور',
                        //         filedSize: r'^.{1,30}$',
                        //         onChanged: (val) {},
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // controller.fileListThumb == null
                        //     ? Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Expanded(
                        //             flex: 4,
                        //             child: Center(
                        //               child: Text(
                        //                 controller.certytitle,
                        //                 style: TextStyle(
                        //                     color: Colors.black,
                        //                     fontFamily: ArabicFonts.Cairo,
                        //                     package: 'google_fonts_arabic',
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //             ),
                        //           ),
                        //           Expanded(
                        //             flex: 1,
                        //             child: IconButton(
                        //               icon: Icon(
                        //                 Icons.add,
                        //                 color: Colors.green,
                        //                 size: 30.0,
                        //               ),
                        //               onPressed: () {
                        //                 controller.pickFiles();
                        //               },
                        //             ),
                        //           ),
                        //         ],
                        //       )
                        //     : Row(),
                        // controller.fileListThumb == null
                        //     ? Row()
                        //     : GridView.count(
                        //         crossAxisCount: 4,
                        //         shrinkWrap: true,
                        //         // scrollDirection: Axis.horizontal,
                        //         children: controller.fileListThumb!,
                        //       ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  CustomeButton(
                    size: size * .8,
                    function: () {},
                    text: "إنشاء حساب",
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
                  // )
                  ;
            }));
  }
}
