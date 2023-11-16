import 'package:aradhana/model/wholewalletmodel.dart';
import 'package:aradhana/screens/Wholewallet/Singleschemedetails.dart';
import 'package:aradhana/service/wholewalletservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class Wholewallet extends StatefulWidget {
  static String routeName = "/Wholewallet";
  const Wholewallet({key}) : super(key: key);

  @override
  _WholewalletState createState() => _WholewalletState();
}

class _WholewalletState extends State<Wholewallet> {
  @override
  void initState() {
    super.initState();
    getScheme();
    // getrole();
  }

  Wholewalletmodel data = new Wholewalletmodel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fixedAssets/whitebg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: data.data != null
            ? SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(),
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                        ),
                        Text(
                          "Wallets",
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            //side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: HexColor("#FECBBB"),
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 20, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: .0),
                                        child: Text(
                                          "TOTAL AMOUNT",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: HexColor("#643036"),
                                              fontSize: 13),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          "\u{20B9} " +
                                              data.data.amountTotal.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: HexColor("#643036")),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Visibility(
                                        visible: false,
                                        child: Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Text("TOTAL GRAM",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                  color: HexColor("#643036"))),
                                        ),
                                      ),
                                      Visibility(
                                        visible: false,
                                        child: Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Text(
                                              data.data.gramTotal.toString() +
                                                  "gram",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: HexColor("#643036"))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                          icon: FaIcon(
                                            FontAwesomeIcons.wallet,
                                            color: HexColor("#707070"),
                                          ),
                                          onPressed: () {
                                            print("Pressed");
                                          }),
                                    ],
                                  ),
                                ],
                              ))),
                    ),
                    Expanded(
                      child: data.data.wallet.isEmpty
                          ? Center(
                              child: Text(
                              "No scheme selected \n Please select a scheme",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              textAlign: TextAlign.center,
                            ))
                          : ListView.builder(
                              itemCount: data.data.wallet.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20, top: 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor("e3e3e3"),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: InkWell(
                                      onTap: () async {
                                        // await saveObject("subscription",
                                        //     subidlist.elementAt(index));
                                        Navigator.pushNamed(context,
                                            Singleschemedetails.routeName,
                                            arguments: data.data.wallet
                                                .elementAt(index));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10,
                                            top: 15,
                                            bottom: 15),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.data.wallet
                                                      .elementAt(index)
                                                      .schemeName
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                Text(
                                                  "Scheme Id : " +
                                                      "Sb-" +
                                                      data.data.wallet
                                                          .elementAt(index)
                                                          .subscriptionId
                                                          .toString()
                                                          .padLeft(5, '0'),
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        250,
                                                                        207,
                                                                        94,
                                                                        1),
                                                                //                   border: Border.all(
                                                                //   color: Colors.red[500],
                                                                // ),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 6,
                                                                    right: 6,
                                                                    top: 2,
                                                                    bottom: 2),
                                                            child: Text(
                                                              "₹" +
                                                                  data.data
                                                                      .wallet
                                                                      .elementAt(
                                                                          index)
                                                                      .amount
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          34,
                                                                          0,
                                                                          0,
                                                                          1),
                                                                  fontSize: 13),
                                                            ))),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Visibility(
                                                      visible: false,
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          250,
                                                                          207,
                                                                          94,
                                                                          1),
                                                                  //                   border: Border.all(
                                                                  //   color: Colors.red[500],
                                                                  // ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20))),
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 6,
                                                                      right: 6,
                                                                      top: 2,
                                                                      bottom:
                                                                          2),
                                                              child: Text(
                                                                data.data.wallet
                                                                        .elementAt(
                                                                            index)
                                                                        .gram
                                                                        .toString() +
                                                                    " grams",
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            34,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontSize:
                                                                        13),
                                                              ))),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            Spacer(),
                                            Icon(Icons
                                                .arrow_forward_ios_outlined)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  ],
                ),
              )
            : Container(),
      ),
    );
  }

  Future<void> getScheme() async {
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);

      Wholewalletmodel datas = await Wholewalletservice.postService();
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      EasyLoading.dismiss();
      setState(() {
        data = datas;
        print(data);
        //  test();
      });
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }
}
