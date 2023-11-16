import 'dart:io';

import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/Widget/ButtonWidget.dart';
import 'package:aradhana/model/Generatepdfdoucment.dart';
import 'package:aradhana/model/Recepitmodel.dart';
import 'package:aradhana/service/Paymentdetailsserivce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

class Recepit extends StatefulWidget {
  static String routeName = "/Recepit";
  @override
  _RecepitState createState() => _RecepitState();
}

class _RecepitState extends State<Recepit> {
  bool shares = false;
  Map datas;
  String gramrate;
  double orignal;
  var paidAmt;
  var aftrCut;
  var cut;
  double originalPrice;
  double walletPrice;
  void getrole() async {
    int role = await getSavedObject("roleid");

    if (role != null) {
      if (role == 2 || role == 4) {
        setState(() {
          shares = false;
        });
      } else if (role == 3) {
        setState(() {
          shares = true;
        });
      }
    }
  }

  // double calculateOriginalPrice(double discountedPrice) {
  //   double originalPrice = (discountedPrice * 100) / (100 - 3);
  //   return originalPrice;
  // }

  int id;

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<bool> _savePdf(String transid) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/Proaims gold flash";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.mediaLibrary)) {
          directory = await getTemporaryDirectory();

          //  directory= (await getApplicationDocumentsDirectory()).path;
        } else {
          print("not reached");
          return false;
        }
      }
      File saveFile = File(directory.path + "/{$transid}Proaims.pdf");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        var pdfdata = await generateDocument(datas);
        var file = File(saveFile.path);
        file.writeAsBytes(pdfdata);
        print(file.path);
        showToast("Recepit saved to file Proaims gold flash");
        if (Platform.isIOS) {
          String ios = (await getApplicationDocumentsDirectory()).path;
          File saveFile = File(ios + "/{$transid}Proaims.pdf");
          var pdfdata = await generateDocument(datas);
          var file = File(saveFile.path);
          file.writeAsBytes(pdfdata);

          print("ios");
          String dirloc = (await getApplicationDocumentsDirectory()).path;
          print(dirloc);
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Future<void> downloadFile() async {
  //   Dio dio = Dio();
  //   bool checkPermission1 =
  //       await SimplePermissions.checkPermission(permission1);
  //   // print(checkPermission1);
  //   if (checkPermission1 == false) {
  //     await SimplePermissions.requestPermission(permission1);
  //     checkPermission1 = await SimplePermissions.checkPermission(permission1);
  //   }
  //   if (checkPermission1 == true) {
  //     String dirloc = "";
  //     if (Platform.isAndroid) {
  //       dirloc = "/sdcard/download/";
  //     } else {
  //       dirloc = (await getApplicationDocumentsDirectory()).path;
  //     }

  //     var randid = random.nextInt(10000);

  //     try {
  //       FileUtils.mkdir([dirloc]);
  //       await dio.download(imgUrl, dirloc + randid.toString() + ".jpg",
  //           onReceiveProgress: (receivedBytes, totalBytes) {
  //         setState(() {
  //           downloading = true;
  //           progress =
  //               ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
  //         });
  //       });
  //     } catch (e) {
  //       print(e);
  //     }

  //     setState(() {
  //       downloading = false;
  //       progress = "Download Completed.";
  //       path = dirloc + randid.toString() + ".jpg";
  //     });
  //   } else {
  //     setState(() {
  //       progress = "Permission Denied!";
  //       _onPressed = () {
  //         downloadFile();
  //       };
  //     });
  //   }
  // }

  @override
  void initState() {
    getrole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20)),
        title: Text("Receipt", style: appBarTxtStyl),
      ),
      body: SafeArea(
          child: FutureBuilder(
        builder: (context, AsyncSnapshot<Recepitmodel> snapshot) {
          if (snapshot.hasData) {
            {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h(10),
                      testWidget(snapshot),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Visibility(
                          visible: false,
                          child: Buttonwidget(
                            click: () {
                              Share.share(
                                "Name :" +
                                    snapshot.data.data.paymentsDetails.name +
                                    "\n" +
                                    "Phone :" +
                                    snapshot.data.data.paymentsDetails.phone +
                                    "\n" +
                                    snapshot.data.data.paymentsDetails
                                        .registrationNumber +
                                    "\n"
                                        "Subscription Scheme Id" +
                                    "Sb-" +
                                    snapshot.data.data.paymentsDetails
                                        .subscriptionId
                                        .toString() +
                                    "\n" +
                                    "Transaction id :" +
                                    "Transaction id :" +
                                    snapshot.data.data.paymentsDetails
                                        .taransactionId +
                                    "\n" +
                                    "Amount" +
                                    snapshot.data.data.paymentsDetails.amount +
                                    "\n" +
                                    "Vocuher number :" +
                                    snapshot.data.data.paymentsDetails
                                        .voucherNumber +
                                    "\n" +
                                    "Date : " +
                                    snapshot
                                        .data.data.paymentsDetails.paymentDate
                                        .toString()
                                        .substring(0, 10) +
                                    '\n' +
                                    'Trade Name : aradhana',
                              );
                            },
                            colors: "#FFD98D",
                            height: 40,
                            label: "Share",
                            labelcolors: "#FFFFFF",
                            width: 100,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: false,
                        child: Center(
                          child: Buttonwidget(
                            click: () {
                              datas = {
                                "Name": snapshot.data.data.paymentsDetails.name,
                                "Phone":
                                    snapshot.data.data.paymentsDetails.phone,
                                "registrationNumber": snapshot.data.data
                                    .paymentsDetails.registrationNumber,
                                "subscriptionId": snapshot
                                    .data.data.paymentsDetails.subscriptionId
                                  ..toString().padLeft(5, '0'),
                                "Transaction id": snapshot
                                    .data.data.paymentsDetails.taransactionId,
                                "Gram rate": gramrate.toString(),
                                "Vocuher number": snapshot
                                    .data.data.paymentsDetails.voucherNumber,
                                "Gram": snapshot.data.data.paymentsDetails.gram
                                    .toString(),
                                "amount": snapshot
                                    .data.data.paymentsDetails.amount
                                    .toString(),
                                "Date": snapshot
                                    .data.data.paymentsDetails.paymentDate
                                    .toString()
                                    .substring(0, 10),
                                "GST": "32ACNPA5138N1ZJ",
                                "Trade Name": "Skygold",
                              };

                              _savePdf(snapshot
                                  .data.data.paymentsDetails.taransactionId);
                            },
                            colors: "#FFD98D",
                            height: 40,
                            label: "Download",
                            labelcolors: "#FFFFFF",
                            width: 110,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          } else {
            return Container();
          }
        },
        future: getPaymentdetails(),
      )),
    );
  }

  Future<Recepitmodel> getPaymentdetails() async {
    Recepitmodel datas;
    Map details = {
      'UserId': await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject('userid'),
      'SheduledDateId': id,
      'subscriptionId': await getSavedObject("subscription")
    };

    try {
      EasyLoading.show(status: 'Loading...');
      print("`````````````details`````````````");
      print(details);
      print("`````````````details`````````````");
      //    showLoading(context);
      datas = await Paymentdetailsservice.paymentDetails(details);
      // paidAmt = double.parse(datas.data.paymentsDetails.paidAmt);
      aftrCut = double.parse(datas.data.paymentsDetails.amount);
      orignal = double.parse(datas.data.paymentsDetails.amount.toString());
      originalPrice = (orignal * 100) / (100 - 3);
      walletPrice = originalPrice - orignal;
      // cut = paidAmt - aftrCut;
      print("```````````````");
      print(paidAmt.toString());
      print("```````````````");
      print("Reached here");

      //  Navigator.of(context).pop(true);
      // showLoading(context);
      EasyLoading.dismiss();

      try {
        gramrate = datas.data.rate.amount.toString();
      } catch (e) {
        gramrate = "";
      }

      //  totalpayment = data.data.sheduledList.length;
      return datas;
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      print(e);
      return datas;
      //  Navigator.pop(context);
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Widget testWidget(snapshot) {
    return ClipPath(
        clipper: MyClipper(),
        child: Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: Column(
              children: [
                Image.asset("assets/receiptLogo.png", height: 60),
                h(10),
                Row(
                  children: [
                    snapshot.data.data.paymentsDetails.taransactionId == "nil"
                        ? Text(
                            "Offline Payment",
                            style: font(12, Colors.black54, FontWeight.w400),
                          )
                        : Text(
                            "Transaction ID:",
                            style: font(12, Colors.black54, FontWeight.w400),
                          ),
                    Spacer(),
                    Text(
                      "Date: " +
                          DateFormat("dd MM-yyyy")
                              .format(snapshot
                                  .data.data.paymentsDetails.paymentDate)
                              .toString()
                              .substring(0, 10),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                h(3),
                // Text("Transaction ID:"),
                // Text(snapshot.data.data.paymentsDetails.taransactionId),
                Row(
                  children: [
                    snapshot.data.data.paymentsDetails.taransactionId == "nil"
                        ? Opacity(
                            opacity: 0,
                          )
                        : Text(
                            snapshot.data.data.paymentsDetails.taransactionId,
                            style: font(12, Colors.black54, FontWeight.w400),
                          ),
                    Spacer(),
                    Text(
                      "Time: " +
                          DateFormat.jm()
                              .format(
                                  snapshot.data.data.paymentsDetails.createdAt)
                              .toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                h(10),

                Row(
                  children: List.generate(
                      150 ~/ 2,
                      (index) => Expanded(
                            child: Container(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.grey[400],
                              height: 2,
                            ),
                          )),
                ),
                h(10),
                detail("Name : ",
                    snapshot.data.data.paymentsDetails.name.toString()),

                detail("Registration Number : ",
                    snapshot.data.data.paymentsDetails.registrationNumber),
                detail("Scheme Name : ",
                    snapshot.data.data.paymentsDetails.schemeName.toString()),
                detail("Phone : ",
                    snapshot.data.data.paymentsDetails.phone.toString()),
                detail(
                    "Gold Rate : ",
                    rs +
                        snapshot.data.data.paymentsDetails.rate
                            .toString()
                            .split('.')[0]),
                detail(
                    "Subscription Scheme Id : ",
                    "Sb-" +
                        snapshot.data.data.paymentsDetails.subscriptionId
                            .toString()),

                detail("Receipt No. : ",
                    snapshot.data.data.paymentsDetails.voucherNumber),

                detail(
                    "Paid Amount  :  ",
                    rs +
                        snapshot.data.data.paymentsDetails.amount
                            .split('.')[0]),
                h(10),
                Row(
                  children: List.generate(
                      150 ~/ 2,
                      (index) => Expanded(
                            child: Container(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.grey[400],
                              height: 2,
                            ),
                          )),
                ),
                h(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detail(
                        "Wallet Amount : ",
                        rs +
                            snapshot.data.data.paymentsDetails.amount
                                .split('.')[0]),
                    snapshot.data.data.paymentsDetails.schemeName.toString() ==
                                "WIN AND WEAR" ||
                            snapshot.data.data.paymentsDetails.schemeName
                                    .toString() ==
                                "MY GOLD"
                        ? Opacity(opacity: 0)
                        : detail(
                            "Weight : ",
                            " " +
                                snapshot.data.data.paymentsDetails.gram
                                    .toString() +
                                " (22kt)")
                  ],
                ),
                h(10),

                Row(
                  children: List.generate(
                      150 ~/ 2,
                      (index) => Expanded(
                            child: Container(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.grey[400],
                              height: 2,
                            ),
                          )),
                ),

                h(20)
              ],
            ),
          ),
        ));
  }

  Widget detail(String title, String txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            txt,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var smallLineLength = size.width / 20;
    const smallLineHeight = 10;
    var path = Path();

    path.lineTo(0, size.height);
    for (int i = 1; i <= 20; i++) {
      if (i % 2 == 0) {
        path.lineTo(smallLineLength * i, size.height);
      } else {
        path.lineTo(smallLineLength * i, size.height - smallLineHeight);
      }
    }
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}
