import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Widget/newBottomDrawer.dart';
import 'package:aradhana/model/SaveSchemeModel.dart';
import 'package:aradhana/model/Sheduledmodel.dart';
import 'package:aradhana/model/offerModel.dart';
import 'package:aradhana/screens/Config/ApiConfig.dart';
import 'package:aradhana/screens/Notifications/Notification.dart';
import 'package:aradhana/service/Sheduledservice.dart';
import 'package:aradhana/service/likePostService.dart';
import 'package:aradhana/service/offerservice.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Util/Utils.dart';

class Offers extends StatefulWidget {
  const Offers({Key key}) : super(key: key);

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  Offermodel reterive;
  bool load = true;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  Sheduledmodel dataa;

  // initializeVideoPlayer() async {
  //   // videoPlayerController = VideoPlayerController.asset("assets/011.mp4");
  //   videoPlayerController = VideoPlayerController.network(videoUrl);
  //   await Future.wait([
  //     videoPlayerController.initialize().then(
  //           (_) => setState(
  //             () => chewieController = ChewieController(
  //                 videoPlayerController: videoPlayerController,
  //                 fullScreenByDefault: true,
  //                 // aspectRatio: 9 / 16,
  //                 aspectRatio: videoPlayerController.value.aspectRatio,
  //                 autoInitialize: true,
  //                 autoPlay: false,
  //                 looping: false),
  //           ),
  //         )
  //   ]);
  //   // chewieController = ChewieController(
  //   //   videoPlayerController: videoPlayerController,
  //   //   // aspectRatio: 16 / 9,
  //   //   autoPlay: true,
  //   //   autoInitialize: true,
  //   //   looping: false,
  //   // );
  // }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  void _launch(String id) async =>
      await canLaunch(id) ? await launch(id) : throw 'Could not launch $id';
//-----------------------------
  YoutubePlayerController _controller;

//-----------------------------
  @override
  void initState() {
    super.initState();
    getOffers();
    getrole();
    _controller = YoutubePlayerController(
      initialVideoId: 'b1G9hSU5ZFw',
      flags: YoutubePlayerFlags(autoPlay: false, mute: false),
    );
    // initializeVideoPlayer();
  }

  int role;
  //String number="";
  final amountController = TextEditingController();
  getrole() async {
    role = await getSavedObject("roleid");
    setState(() {
      role;
    });
    print(role);
    //number= await getSavedObject("phone");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(
        elevation: 2,
        title: Image.asset("assets/logoOnly.png", height: 40),
        centerTitle: true,
        leading: role == 2 || role == 4
            ? Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.sort, size: 30),
                      onPressed: () {
                        newDrawerr(
                            context, dataa.data.termsandcondtion.description);
                      }),
                ),
              )
            : Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
        actions: [
          role == 2 || role == 4
              ? InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Notifications.routeName,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Center(
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Icon(Icons.notifications, size: 30),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
      body: load == true
          ? Opacity(opacity: 0)
          : reterive.data.offers.length == 0
              ? Center(
                  child: Text("No posts to show!",
                      style: font(15, Colors.black54, FontWeight.w500)),
                )
              : Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                  child: ListView(
                    children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15),
                      //       color: Colors.white),
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(bottom: 15, top: 10),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         SizedBox(
                      //           height:
                      //               MediaQuery.of(context).size.height * 0.6,
                      //           child: YoutubePlayer(
                      //             controller: _controller,
                      //             bottomActions: [
                      //               CurrentPosition(),
                      //               ProgressBar(isExpanded: true),
                      //               RemainingDuration(),
                      //               // FullScreenButton(),
                      //             ],
                      //             aspectRatio: 9 / 16,
                      //             showVideoProgressIndicator: true,
                      //             progressIndicatorColor: Colors.amber,
                      //             progressColors: ProgressBarColors(
                      //               playedColor: Colors.amber,
                      //               handleColor: Colors.amberAccent,
                      //             ),
                      //             onReady: () {
                      //               _controller.addListener(() {});
                      //             },
                      //           ),
                      //         ),
                      //         h(10),
                      //         Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 15),
                      //           child: Text(
                      //               "Welcome to Aradhana Jewellery Kannur",
                      //               style: size12_600),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // h(15),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: reterive.data.offers.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              ReqAmount(
                                  ApiConfigs.imageurls +
                                      reterive.data.offers
                                          .elementAt(index)
                                          .image,
                                  reterive.data.offers
                                      .elementAt(index)
                                      .productName,
                                  reterive.data.offers.elementAt(index));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: Colors.white12, width: 0.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15)),
                                    child: Image.network(
                                        ApiConfigs.imageurls +
                                            reterive.data.offers
                                                .elementAt(index)
                                                .image,
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover),
                                  ),
                                  h(5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0, right: 16),
                                              child: Text(
                                                  reterive.data.offers
                                                      .elementAt(index)
                                                      .productName,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          HexColor('242424'))),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0, right: 16),
                                              child: ReadMoreText(
                                                reterive.data.offers
                                                    .elementAt(index)
                                                    .description,
                                                trimLines: 2,
                                                colorClickableText: Colors.pink,
                                                trimMode: TrimMode.Line,
                                                trimCollapsedText: 'Show more',
                                                trimExpandedText:
                                                    '  \n ....Show less',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: HexColor('574545')),
                                                lessStyle: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                moreStyle: TextStyle(
                                                    fontSize: 12,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // child: Text(
                                              //     reterive.data.offers
                                              //         .elementAt(index)
                                              //         .description,
                                              //     style: TextStyle(
                                              //         fontSize: 12,
                                              //         fontWeight: FontWeight.w400,
                                              //         color: HexColor('574545'))),
                                            )
                                          ],
                                        ),
                                      ),
                                      // DottedBorder(
                                      //   color: Colors.black54,
                                      //   strokeWidth: 1,
                                      //   dashPattern: [6, 4],
                                      //   borderType: BorderType.RRect,
                                      //   radius: Radius.circular(5),
                                      //   child: InkWell(
                                      //     onTap: () {
                                      //       Clipboard.setData(new ClipboardData(
                                      //           text: reterive.data.offers
                                      //               .elementAt(index)
                                      //               .offerCode));
                                      //       showToast("Code Copied");
                                      //     },
                                      //     child: Padding(
                                      //       padding: const EdgeInsets.symmetric(
                                      //           horizontal: 5, vertical: 5),
                                      //       child: Row(
                                      //         children: [
                                      //           Text(
                                      //             reterive.data.offers
                                      //                 .elementAt(index)
                                      //                 .offerCode,
                                      //             style: TextStyle(
                                      //                 color: HexColor('1B8638'),
                                      //                 fontSize: 12),
                                      //           ),
                                      //           w(10),
                                      //           Icon(
                                      //             Icons.copy,
                                      //             size: 18,
                                      //             color: Colors.black54,
                                      //           )
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      w(10)
                                    ],
                                  ),
                                  h(10),
                                  Divider(height: 2),
                                  // ExpansionTile(
                                  //   title: Row(
                                  //     children: [
                                  //       likeBttn(),
                                  //     ],
                                  //   ),
                                  //   trailing: Icon(CupertinoIcons.chat_bubble_fill,
                                  //       color: Colors.black54),
                                  //   childrenPadding: EdgeInsets.symmetric(
                                  //       vertical: 10, horizontal: 15),
                                  //   expandedAlignment: Alignment.centerLeft,
                                  //   children: [
                                  //     Container(
                                  //       child: SingleChildScrollView(
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             Text("comments"),

                                  //           ],
                                  //         ),
                                  //       ),
                                  //       height: 100,
                                  //       width: double.infinity,
                                  //     ),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, right: 16),
                                        child: LikeButton(
                                          size: 30,
                                          onTap: (bool isLiked) {
                                            return onLikeButtonTapped(
                                                isLiked,
                                                reterive.data.offers
                                                    .elementAt(index)
                                                    .id);
                                          },
                                          likeCountAnimationType:
                                              LikeCountAnimationType.all,
                                          circleColor: CircleColor(
                                              start: iconClr, end: bgClr),
                                          bubblesColor: BubblesColor(
                                              dotPrimaryColor: inputClr,
                                              dotSecondaryColor: bgClr),
                                          likeBuilder: (bool isLiked) {
                                            return Icon(
                                              reterive.data.offers
                                                          .elementAt(index)
                                                          .isLiked ==
                                                      false
                                                  ? Icons.thumb_up_alt_outlined
                                                  : Icons.thumb_up,
                                              color: reterive.data.offers
                                                          .elementAt(index)
                                                          .isLiked ==
                                                      false
                                                  ? Colors.grey
                                                  : Colors.red,
                                              size: 20,
                                            );
                                          },
                                          likeCount: reterive.data.offers
                                              .elementAt(index)
                                              .likeCount,
                                          countBuilder: (int count,
                                              bool isLiked, String text) {
                                            var color = isLiked
                                                ? Colors.red
                                                : Colors.grey;
                                            Widget result;
                                            if (count == 0) {
                                              result = Text(
                                                "Like!",
                                                style: TextStyle(
                                                    color: color, fontSize: 13),
                                              );
                                            } else
                                              result = Text(
                                                text,
                                                style: TextStyle(color: color),
                                              );
                                            return result;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  h(10),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
    );
  }

  getOffers() async {
    Map details = {
      'UserId': await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject('userid'),
      'subscriptionId': await getSavedObject('subscription')
    };
    try {
      Sheduledmodel datas = await Sheduledservice.postService(details);
      setState(() {
        dataa = datas;
      });
      print("try");

      EasyLoading.show(status: 'Loading...');
      // showLoading(context);
      Offermodel reteriveData = await Offerservice.getOffers();
      print(reteriveData);
      setState(() {
        EasyLoading.dismiss();
        reterive = reteriveData;
        load = false;
      });
    } catch (e) {
      print("catchhh");
      showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }

  // likeBttn(int likesCount, iindex) {
  //   return LikeButton(
  //     size: 30,
  //     onTap: (iindex) {
  //       return onLikeButtonTapped(iindex);
  //     },
  //     likeCountAnimationType: LikeCountAnimationType.all,
  //     circleColor: CircleColor(start: iconClr, end: bgClr),
  //     bubblesColor:
  //         BubblesColor(dotPrimaryColor: inputClr, dotSecondaryColor: bgClr),
  //     likeBuilder: (bool isLiked) {
  //       return Icon(
  //         Icons.thumb_up,
  //         color: isLiked ? Colors.red : Colors.grey,
  //         size: 20,
  //       );
  //     },
  //     likeCount: likesCount,
  //     countBuilder: (int count, bool isLiked, String text) {
  //       var color = isLiked ? Colors.red : Colors.grey;
  //       Widget result;
  //       if (count == 0) {
  //         result = Text(
  //           "Like!",
  //           style: TextStyle(color: color, fontSize: 13),
  //         );
  //       } else
  //         result = Text(
  //           text,
  //           style: TextStyle(color: color),
  //         );
  //       return result;
  //     },
  //   );
  // }

  Future<bool> onLikeButtonTapped(bool isLiked, int id) async {
    Map details = {
      'postId': id,
      'chk': 1,
    };
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);
      SaveSchemeModel datas = await likePostService.like(details);

      if (datas.success) {
        getOffers();
        print("success");
        // Navigator.pop(context);
      }

      EasyLoading.dismiss();

      // return datas;
    } catch (e) {
      // showErrorMessage(e);

      EasyLoading.dismiss();
      Navigator.pop(context);
      print(e);
      //  Navigator.pop(context);

    }

    return !isLiked;
  }

  void ReqAmount(img, desc, xx) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 10),
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(12)),
        elevation: 10,
        // contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        // title: Text(''),
        child: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: PhotoView(
                        tightMode: true,
                        minScale: PhotoViewComputedScale.contained * 0.5,
                        maxScale: PhotoViewComputedScale.covered * 2,
                        backgroundDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        imageProvider: NetworkImage(img),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 1, right: 1, top: 1),
                  //   child: Container(
                  //     height: MediaQuery.of(context).size.height * 0.3,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.only(
                  //             topRight: Radius.circular(12),
                  //             topLeft: Radius.circular(12)),
                  //         image: DecorationImage(
                  //             image: NetworkImage(img), fit: BoxFit.cover)),
                  //   ),
                  // ),
                  // Image.network(img),
                  // Divider(),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(left: 16, right: 16, bottom: 15),
                  //   child: Text(
                  //     desc,
                  //     style:
                  //         TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  //   ),
                  // ),
                  // Divider(),
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 16.0, right: 16),
                  //       child: LikeButton(
                  //         size: 30,
                  //         onTap: (bool isLiked) {
                  //           return onLikeButtonTapped(isLiked, xx.id);
                  //         },
                  //         likeCountAnimationType: LikeCountAnimationType.all,
                  //         circleColor: CircleColor(start: iconClr, end: bgClr),
                  //         bubblesColor: BubblesColor(
                  //             dotPrimaryColor: inputClr,
                  //             dotSecondaryColor: bgClr),
                  //         likeBuilder: (bool isLiked) {
                  //           return Icon(
                  //             xx.isLiked == false
                  //                 ? Icons.thumb_up_alt_outlined
                  //                 : Icons.thumb_up,
                  //             color: xx.isLiked == false
                  //                 ? Colors.grey
                  //                 : Colors.red,
                  //             size: 20,
                  //           );
                  //         },
                  //         likeCount: xx.likeCount,
                  //         countBuilder: (int count, bool isLiked, String text) {
                  //           var color = isLiked ? Colors.red : Colors.grey;
                  //           Widget result;
                  //           if (count == 0) {
                  //             result = Text(
                  //               "Like!",
                  //               style: TextStyle(color: color, fontSize: 13),
                  //             );
                  //           } else
                  //             result = Text(
                  //               text,
                  //               style: TextStyle(color: color),
                  //             );
                  //           return result;
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
