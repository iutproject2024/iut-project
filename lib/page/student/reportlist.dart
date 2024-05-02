import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:iutapp/controller/student_controller.dart';

import '../../controller/scroll_controller.dart';
import '../../utils/appcolor.dart';
import '../../widget/circleavatar.dart';
import '../../widget/custome_button.dart';

class ReportList extends StatelessWidget {
  final StudentController studentController = Get.find();
  final ScrollToTopController sController = Get.put(ScrollToTopController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(builder: (controller) {
      return Column(
        children: [
          Expanded(
              flex: 1,
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomeButton(
                      text: "التقارير",
                      function: () {
                        controller.getReport(1);
                      },
                      colors: AppColor.buttonColor,
                      size: MediaQuery.of(context).size * .8,
                      textStyle: TextStyle(
                          color: AppColor.textColor,
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold),
                    ),
              ),
                ),
          Expanded(
              flex: 11,
              child: controller.reports.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      controller: sController.msgScroll,
                      itemCount: controller.reports.length,
                      itemBuilder: (context, i) {
                        Timestamp time = controller.reports[i]['date'];

                        String tim = time.toDate().toString().substring(0, 16);
                        var user = GetStorage().read('user');
                        var postUserId = controller.reports[i]['userid'];
                        var userId = user['id'];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            // color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          CustomeCircleAvatar(controller
                                              .reports[i]['userimage']),
                                          const SizedBox(width: 8.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller.reports[i]['name'],
                                                  // post.user.name,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      // '${post.timeAgo} • ',
                                                      tim,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 8.0,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.public,
                                                      color: Colors.grey[600],
                                                      size: 12.0,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          postUserId == userId
                                              ? Row(
                                                  children: [
                                                    // IconButton(
                                                    //   icon: const Icon(Icons.edit, color: Colors.green, size: 20),
                                                    //   onPressed: () async{
                                                    //     //
                                                    //   },
                                                    // ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                          size: 20),
                                                      onPressed: () async {
                                                        controller.deleteReport(
                                                            controller
                                                                    .reports[i]
                                                                ['id']);
                                                      },
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                          postUserId != userId
                                              ? IconButton(
                                                  icon: const Icon(Icons.share,
                                                      color: Colors.black,
                                                      size: 20),
                                                  onPressed: () {
                                                    // dialogDelete(context, widget.dataPost.idpost);
                                                    // deletePost(widget.dataPost.idpost);
                                                  },
                                                )
                                              : SizedBox.shrink(),
                                        ],
                                      ),
                                      const Divider(),
                                      Text(controller.reports[i]['text']),
                                      const SizedBox(height: 4.0),
                                      controller.reports[i]['image'] != null
                                          ? const SizedBox.shrink()
                                          : const SizedBox(height: 6.0),
                                    ],
                                  ),
                                ),
                                controller.reports[i]['image'] != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        // height: 400,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: controller.reports[i]
                                              ['image'],
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        // Image.network(path_images_post + img_post),
                                      )
                                    : const SizedBox(),
                                const SizedBox(height: 6.0),
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(
                      child: CustomeButton(
                        text: "لا يوجد لديك أي تقارير",
                        function: () {
                          controller.getReport(1);
                        },
                        colors: AppColor.buttonColor,
                        size: MediaQuery.of(context).size * .8,
                        textStyle: TextStyle(
                            color: AppColor.textColor,
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold),
                      ),
                    ))
        ],
      );
    });
  }
}
