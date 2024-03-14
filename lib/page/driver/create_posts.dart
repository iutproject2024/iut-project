import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
//

  //
  // PostsClinet postclin;
  //
  TextEditingController _dataTx = new TextEditingController();

  bool visibilityObdoctor = false;
  bool visibilityOb = false;

  int imgI = 1;

  var id_doc;

  bool isloding = false;

  Image? img;
  File? image;
  var imageFile;
  //
  String base64 = "";
  String fileNameon = "";
  String base65 = "";
  String fileNametwo = "";
  String base66 = "";
  String fileNamethree = "";
  int? res;
  // Future getImageGallery(ImageSource imageSource) async {
  //   imageFile = await ImagePicker()
  //       .getImage(source: imageSource, maxWidth: 480, maxHeight: 250);
  //   //  , maxWidth: 480, maxHeight: 300
  //   print("ggggggggggggggggggggggggggggggggg");
  //   setState(() {
  //     image = File(imageFile.path);
  //     visibilityObdoctor ? null : changedD(true);
  //     // print(base64);
  //     // print(fileName);
  //   });
  // }

  // Post_Provider postProvider;
  // PostsClinet postClient;

  // Future<void> getPosts() async {
  //   postProvider = Provider.of<Post_Provider>(context, listen: false);
  //   postClient = PostsClinet(postProvider);
  //   // if (PostProvider.postLists.isEmpty) {
  //   postProvider.postLists.clear();
  //   postClient.getDataPost(2.toString());
  //   // }
  // }
  FirebaseStorage _storage = FirebaseStorage.instance;

  void addPost(String dataPost) async {
    //
    // if (imgon != null) {
    //   base64 = base64Encode(imgon!.readAsBytesSync());
    //   fileNameon = imgon!.path.split('/').last;
    // }

    // var data = {
    //   "type_query": 1.toString(),
    //   "data_post": _dataTx.text,
    //   "img_post": fileNameon,
    //   "img_postTo": fileNametwo,
    //   "img_postTh": fileNamethree,
    //   "image64": base64,
    //   "image65": base65,
    //   "image66": base66,
    //   // "ID_doc": G_doc_ID_val.toString(),
    // };
    var imageName = DateTime.now().millisecondsSinceEpoch.toString();

    var storageRef =
        FirebaseStorage.instance.ref().child('post_images/$imageName.jpg');
    var uploadTask = storageRef.putFile(imgon!);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();
    var user = GetStorage().read('user');
    await FirebaseFirestore.instance.collection('posts').doc().set({
      'userid': user['id'],
      'userimage': user['image_url'],
      'name': user['name'],
      'text': _dataTx.text,
      'image': downloadUrl,
      'date': DateTime.now(),
    }).then((value) {
      _dataTx.clear();
      imgon=null;
      // showSnakbar(
      //     'نجاح', 'تمت عملية التسجيل ب نجاح', Icons.login, Colors.green);
    });
 
  }

  File? imgon;
  bool visblimgon = false;

  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future getImageGallery(ImageSource imageSource) async {
    try {
      final pickImageFile = await _picker.getImage(
          source: imageSource, imageQuality: 50, maxWidth: 150);
      if (pickImageFile != null) {
        imgon = File(pickImageFile.path);
        visblimgon = true;
        setState(() {});
      }
      setState(() {
        // if (imgI == 3) {}
        // visibilityObdoctor ? null : changedD(true);
      });

      // });
    } on PlatformException catch (e) {
      print("Arrrrrrrrrrrrorrr");
    }
  }

//
  @override
  void initState() {
    // getspecialty();
    // TODO: implement initState
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width - 50,
      margin: EdgeInsets.only(right: 2, left: 2),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.0, style: BorderStyle.solid, color: Colors.blueGrey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        color: Colors.white.withOpacity(0.8),
      ),
      // Expanded
      // height: MediaQuery.of(context).size.height / 5.5,
      // width: MediaQuery.of(context).size.width - 2,
      child: Column(
        children: [
          SizedBox(height: 5),
          TextFormField(
            controller: _dataTx,
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

          // visblimgon
          //     ?
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            // color: Colors.blue,
            height: 100,
            width: MediaQuery.of(context).size.width - 5,
            child: Center(
              child: visblimgon
                  ? InkWell(
                      child:imgon!=null? imageCer(imgon!):Row(),
                      onTap: () async {
                        // await Future.delayed(Duration(seconds: 0));
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
                                    setState(() {
                                      visblimgon = false;
                                    });
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
                  : SizedBox(width: 3), // : SizedBox(),
            ),
          ),

          const Divider(height: 10.0, thickness: 0.5),
          //
          Container(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {
                    getImageGallery(ImageSource.camera);
                  },
                  icon: const Icon(
                    Icons.camera_enhance,
                    color: Colors.red,
                    size: 20,
                  ),
                  label: Text('الـكـاميرا'),
                ),
                const VerticalDivider(width: 8.0),
                ///////////////////////////////////////////
                TextButton.icon(
                  onPressed: () {
                    getImageGallery(ImageSource.gallery);
                  },
                  icon: const Icon(
                    Icons.photo_library,
                    color: Colors.green,
                    size: 20,
                  ),
                  label: Text('معرض الصور'),
                ),
                const VerticalDivider(width: 8.0),
                ///////////////////////////////////////////////////
                TextButton.icon(
                  onPressed: () {
                    addPost(_dataTx.text);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                    size: 30,
                  ),
                  label: Text(
                    'اضــافــه',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////
              ],
            ),
          ),

          //
        ],
      ),
      // child: Expanded(
      //   // key: formstatesignup,
      //   child: Text("saddam"),
      // ),
    );
  }

  //
  Container imageCer(File imgis) {
    return Container(
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.greenAccent.withOpacity(0.5),
                // offset: const Offset(2.0, 4.0),
                blurRadius: 8),
          ],
        ),
        // color: Colors.blue,
        height: 90,
        width: 80,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Hero(
            tag: imgis,
            child: Image.file(imgis, fit: BoxFit.fill),
          ),
        )
        // Image.file(image),
        );
    //add_img.jpg;
  }

  //
  showToasts(String text) {
    Get.snackbar(
      text,
      text,
      snackStyle: SnackStyle.FLOATING,
      icon: Icon(Icons.error, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      // backgroundColor: color,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 1),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
    // showToast(text,
    //   context: context,
    //   animation: StyledToastAnimation.fadeRotate,
    //   reverseAnimation: StyledToastAnimation.fadeScale,
    //   position: StyledToastPosition.center,
    //   animDuration: Duration(seconds: 1),
    //   duration: Duration(seconds: 4),
    //   curve: Curves.linear,
    //   reverseCurve: Curves.linear);
    //
  }
  //
}
