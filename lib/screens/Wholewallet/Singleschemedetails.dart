import 'package:aradhana/model/wholewalletmodel.dart';
import 'package:flutter/material.dart';

class Singleschemedetails extends StatefulWidget {
  static String routeName = "/Singleschemedetails";
  const Singleschemedetails({key}) : super(key: key);

  @override
  _SingleschemedetailsState createState() => _SingleschemedetailsState();
}

class _SingleschemedetailsState extends State<Singleschemedetails> {
  Wallet data = new Wallet();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        data = ModalRoute.of(context).settings.arguments;
      });
    });
  }

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
        child: SafeArea(
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
              data.amount.toString().compareTo("0") != 0
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: data.wal.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    //side: BorderSide(color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15,
                                          top: 10,
                                          bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "VoucherNumber :",
                                              ),
                                              Text(
                                                  data.wal
                                                      .elementAt(index)
                                                      .voucherNumber,
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Date : ",
                                              ),
                                              Text(
                                                  data.wal
                                                      .elementAt(index)
                                                      .paymentDate
                                                      .toString()
                                                      .substring(0, 10),
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          250, 207, 94, 1),
                                                      //                   border: Border.all(
                                                      //   color: Colors.red[500],
                                                      // ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 6,
                                                              right: 6,
                                                              top: 2,
                                                              bottom: 2),
                                                      child: Text(
                                                        "₹" +
                                                            data.wal
                                                                .elementAt(
                                                                    index)
                                                                .amount,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
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
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            250, 207, 94, 1),
                                                        //                   border: Border.all(
                                                        //   color: Colors.red[500],
                                                        // ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius
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
                                                          data.wal
                                                                  .elementAt(
                                                                      index)
                                                                  .gram +
                                                              " grams",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(34,
                                                                      0, 0, 1),
                                                              fontSize: 13),
                                                        ))),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ))),
                            );
                          }),
                    )
                  : Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.45,
                            ),
                            Center(
                              child: Text(
                                "No payment details available",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
