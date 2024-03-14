import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';

import '../../utils/appcolor.dart';
import '../../widget/custome_button.dart';

class PostList extends StatefulWidget {
  final int type;

  const PostList({super.key, required this.type});
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  var user = GetStorage().read('user');
  ScrollController? _scrollController;

  var posts = [];
  void getposts() async {
    posts = [];

    var collection;

    if (widget.type == 1) {
      collection = FirebaseFirestore.instance
          .collection('posts')
          .where('userid', isEqualTo: user['id']);
    } else {
      collection = FirebaseFirestore.instance.collection('posts');
    }
    var querySnapshot = await collection.get();
    var list = [];
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      list.add(data);
    }
    posts = list;
  }

  @override
  void initState() {
    getposts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width - 4,
        child: Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Column(
                
                children: [
                  posts.length>0
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: posts.length,
                          itemBuilder: (context, i) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                                          PostHeader(posts[i]),
                                          const Divider(),
                                          Text(posts[i]['text']),
                                          const SizedBox(height: 4.0),
                                          posts[i]['image'] != null
                                              ? const SizedBox.shrink()
                                              : const SizedBox(height: 6.0),
                                        ],
                                      ),
                                    ),
                                    posts[i]['image'] != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            // height: 400,
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: posts[i]['image'],
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
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
                            text: "لا يوجد أي منشورات",
                            function: () {},
                            colors: AppColor.buttonColor,
                            size: MediaQuery.of(context).size * .8,
                            textStyle: TextStyle(
                                color: AppColor.textColor,
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                ],
              ),
            )));
  }
}

class PostContainer extends StatelessWidget {
  var post = [];
  PostContainer(this.post);
  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PostHeader(post[0]),
                  Divider(),
                  Text(post[0]['text']),
                  const SizedBox(height: 4.0),
                ],
              ),
            ),
            const SizedBox(height: 6.0),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PostHeader extends StatelessWidget {
  var dataPost;

  PostHeader(
    this.dataPost,
  );
  @override
  Widget build(BuildContext context) {
    Timestamp time = dataPost['date'];

    String tim = time.toDate().toString().substring(0, 16);
    var user = GetStorage().read('user');
    var postUserId = dataPost['userid'];
    var userId = user['id'];
    return Row(
      children: [
        ProfileAvatar(imageUrl: dataPost['userimage']),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataPost['name'],
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
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.green, size: 20),
                    onPressed: () {
                      // dialogDelete(context, widget.dataPost.idpost);
                      // deletePost(widget.dataPost.idpost);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                    onPressed: () {
                      // dialogDelete(context, widget.dataPost.idpost);
                      // deletePost(widget.dataPost.idpost);
                    },
                  ),
                ],
              )
            : SizedBox(),
        //

        postUserId != userId
            ? IconButton(
                icon: const Icon(Icons.share, color: Colors.black, size: 20),
                onPressed: () {
                  // dialogDelete(context, widget.dataPost.idpost);
                  // deletePost(widget.dataPost.idpost);
                },
              )
            : SizedBox.shrink(),
      ],
    );
  }

  dialogtypeimg(context, int type) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Center(child: Text('حول المنشور')),
            content: Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                children: [
                  // type == 1
                  //     ? InkWell(
                  //         onTap: () {
                  //           Navigator.of(context).pop();
                  //         },
                  //         child: buttom("تــعــديـــل"))
                  //     : SizedBox(),
                  // type == 1 ? SizedBox(height: 5) : SizedBox(),
                  // type == 1
                  //     ? InkWell(
                  //         onTap: () {
                  //           Navigator.of(context).pop();
                  //         },
                  //         child: buttom("حـــــــذف"))
                  //     : SizedBox(),
                  // SizedBox(height: 5),
                  // InkWell(
                  //     onTap: () {
                  //       Navigator.of(context).pop();
                  //     },
                  //     child: buttom("مـشـاركـة الـمـنـشـور")),
                  // SizedBox(height: 5),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text("   خــروج  ",
                    style: TextStyle(
                      color: Colors.red,
                    )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  //
  dialogDelete(context, String idPost) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Center(child: Text('حـــذف ')),
            content: Container(
                height: MediaQuery.of(context).size.height / 9,
                child: Text('هل انت متأكد من حذف هذا المنشور ')),
            actions: <Widget>[
              SizedBox(
                width: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text("   خــروج  ",
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text("   حــــذف  ",
                        style: TextStyle(color: Colors.red, fontSize: 18)),
                    onPressed: () {
                      // deletePost(widget.dataPost.idpost);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              // SizedBox(
              //   width: 20,
              // ),
            ],
          );
        });
  }

  //
  Container buttom(String saddam, int fun, String idpost, IconData icon,
      BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .1,
      child: InkWell(
        onTap: () {
          if (fun == 1) {
          } else if (fun == 2) {
            // deletePost(idpost);
          } else if (fun == 3) {
          } else if (fun == 4) {
          } else {}
        },
        child: Icon(
          icon,
          color: AppColor.buttonColor,
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  // final bool isActive;
  // final bool hasBorder;

  const ProfileAvatar({
    this.imageUrl,
    // this.isActive = false,
    // this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 20.0,
          // backgroundColor: Palette.facebookBlue,
          child: CircleAvatar(
            radius: true ? 17.0 : 20.0,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(imageUrl!),
          ),
        ),
        true
            ? Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
