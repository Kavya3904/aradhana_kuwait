// import 'package:arabiangold/Util/Utils.dart';
// import 'package:arabiangold/model/Paymentdetailsmodel.dart';
// import 'package:arabiangold/model/Sheduledmodel.dart';
// import 'package:arabiangold/screens/MyPackage/PaymentHistroywidget.dart';
// import 'package:arabiangold/screens/MyPackage/Paymentdetailswidget.dart';
// import 'package:arabiangold/screens/Notifications/Notification.dart';
// import 'package:arabiangold/service/Paymentdetailsserivce.dart';
// import 'package:arabiangold/service/Sheduledservice.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:step_progress_indicator/step_progress_indicator.dart';

// import '../HomeScreen/Dashboardhome.dart';

// class MyPackage extends StatefulWidget {
//   static String routeName = "/MyPackage";
//   @override
//   _MyPackageState createState() => _MyPackageState();
// }

// class _MyPackageState extends State<MyPackage> {
//   var paymentpendingid;
//   var paymentdate;
//   var schemeId;
//   var schemeAmountId;
//   var paymentStartDates;
//   var paymentEndDates;
//   String upistatus = "0";
//   bool vis = false;
//   int totalpayed = 0;
//   int role;
//   Sheduledmodel data = new Sheduledmodel();
//   @override
//   void initState() {
//     super.initState();
//     getProfile();
//     getrole();
//   }

//   getrole() async {
//     role = await getSavedObject("roleid");
//     print(role);
//     //number= await getSavedObject("phone");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     //  backgroundColor: HexColor("720755"),
//       body: SafeArea(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       role == 2 || role == 4
//                           ? Container(
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 // color: HexColor("#ffffff")
//                               ),
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 15.0, top: 5),
//                                 child: IconButton(
//                                     icon: Icon(Icons.menu,
//                                         color: HexColor("#720755")),
//                                     onPressed: () {
//                                       Scaffold.of(context).openDrawer();
//                                     }),
//                               ),
//                             )
//                           : Container(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(right: 0),
//                                 child: IconButton(
//                                     icon: Icon(
//                                       Icons.arrow_back,
//                                       color: Colors.black,
//                                     ),
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     }),
//                               ),
//                             ),
//                       // : Container(
//                       //     decoration: BoxDecoration(
//                       //         shape: BoxShape.circle,
//                       //         color: Colors.black),
//                       //     child: IconButton(
//                       //         icon: Icon(Icons.switch_account,
//                       //             color: HexColor("#FFD98D")),
//                       //         onPressed: () {
//                       //           Navigator.pushReplacementNamed(
//                       //             context,
//                       //             SelectScheme.routeName,
//                       //           );
//                       //         }),
//                       //   ),

//                       Spacer(),
//                       role == 2 || role == 4
//                           ? InkWell(
//                               onTap: () {
//                                 Navigator.pushNamed(
//                                   context,
//                                   Notifications.routeName,
//                                 );
//                               },
//                               child:  Container(
//                                     width: 30,
//                                     height: 30,
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           child: Icon(
//                                             Icons.notifications,
//                                             color: HexColor("#720755"),
//                                             size: 25,
//                                           ),
//                                         ),
//                                         data.data.notificationCount == 0
//                                             ? Container()
//                                             : Container(
//                                                 width: 30,
//                                                 height: 30,
//                                                 alignment: Alignment.topRight,
//                                                 margin: EdgeInsets.only(top: 0),
//                                                 child: Container(
//                                                   width: 16,
//                                                   height: 16,
//                                                   decoration: BoxDecoration(
//                                                       shape: BoxShape.circle,
//                                                       color: Color(0xffc32c37),
//                                                       border: Border.all(
//                                                           color: Colors.white,
//                                                           width: 1)),
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             0.0),
//                                                     child: Center(
//                                                       child: Text(
//                                                         data.data
//                                                             .notificationCount
//                                                             .toString(),
//                                                         style: TextStyle(
//                                                             fontSize: 9,
//                                                             color:
//                                                                 Colors.white),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                       ],
//                                     ),
//                                   ),
//                             )
//                           : Container(),

// //                           Container(
// //                             child: Stack(
// //                               children: [
// //                                 Container(
// //                                   decoration: BoxDecoration(
// //                                 shape: BoxShape.circle, color: Colors.black),
// //                                   child: IconButton(
// //                                       icon: Icon(Icons.notifications,
// //                                           color: HexColor("#FFD98D")),
// //                                       onPressed: null),
// //                                 ),
// //  Container(
// //         width: 30,
// //         height: 30,
// //         alignment: Alignment.topRight,
// //         margin: EdgeInsets.only(top: 5),
// //         child: Container(
// //           width: 15,
// //           height: 15,
// //           decoration: BoxDecoration(
// //               shape: BoxShape.circle,
// //               color: Color(0xffc32c37),
// //               border: Border.all(color: Colors.white, width: 1)),
// //           child: Padding(
// //             padding: const EdgeInsets.all(0.0),
// //             child: Center(
// //               child: Text(
// //                data.data.notificationCount.toString(),
// //                 style: TextStyle(fontSize: 5),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //                               ],
// //                             ),
// //                           ),
//                       SizedBox(
//                         width: 10,
//                       ),

//                       role == 4
//                           ? Container(
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle, color: Colors.black),
//                               child: IconButton(
//                                   icon: Icon(
//                                     Icons.home,
//                                     color: Colors.black,
//                                     size: 20,
//                                   ),
//                                   onPressed: () {
//                                     Navigator.pushNamed(
//                                       context,
//                                       Dashboardhome.routeName,
//                                     );
//                                   }),
//                             )
//                           : Container(),
//                     ],
//                   ),

//                     SizedBox(
//                         height: 5,
//                       ),
//        Container(color: HexColor("#A7A7A7"),height: 1,width: MediaQuery.of(context).size.width,),
//                       SizedBox(
//                         height: 15,
//                       ),
//                   Expanded(
//                     child:         Paymentdetailswidget(
//                                         // data: data,
//                                         // paymentEndDates: paymentEndDates,
//                                         // paymentStartDates: paymentStartDates,
//                                         paymentdate: paymentdate,
//                                         // paymentpendingid: paymentpendingid,
//                                         // schemeAmountId: schemeAmountId,
//                                         // schemeId: schemeId,
//                                         // totalpayed: totalpayed,
//                                         // vis: vis,
//                                         paymentrefresh: getProfile,
//                                  //       upistatus: upistatus,

//                                       ),
//                   ),
//                 ],
//               ),
//             )
//           : Container(),
//     );
//   }

//   Future<Sheduledmodel> getProfile() async {
//     totalpayed = 0;
//     vis = false;
//     Map details = {
//       'UserId': await getSavedObject("roleid") == 3
//           ? await getSavedObject("customerid")
//           : await getSavedObject('userid'),
//       'subscriptionId': await getSavedObject('subscription')
//     };
//     print(details);
//     try {
//       EasyLoading.show(status: 'Loading...');
//       //    showLoading(context);
//       Sheduledmodel datas = await Sheduledservice.postService(details);

//       setState(() {
//         data = datas;
//       });

//       //  Navigator.of(context).pop(true);
//       // showLoading(context);
//       EasyLoading.dismiss();

//       //  totalpayment = data.data.sheduledList.length;
//       datas.data.sheduledList.forEach((element) {
//         if (element.status == 2) {
//           totalpayed++;
//         } else if (element.status == 1) {
//           setState(() {
//             paymentpendingid = element.id;
//             schemeId = element.schemeId;
//             schemeAmountId = element.schemeAmountId;
//             paymentStartDates = element.paymentStartDates;
//             paymentEndDates = element.paymentEndDates;
//             upistatus = element.upiStatus.toString();
//             vis = true;
//           });
//         }
//       });
//       return datas;
//     } catch (e) {
//       // showErrorMessage(e);
//       EasyLoading.dismiss();
//       print(e);
//       //  Navigator.pop(context);
//     }
//   }
// }
