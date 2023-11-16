import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Util/Utils.dart';
import 'package:aradhana/model/Subscriptionlistmodel.dart';
import 'package:aradhana/screens/HomeScreen/HomeTab.dart';
import 'package:aradhana/screens/Packageselect/Selectpackage.dart';
import 'package:aradhana/service/Schemelistgetservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';

class Customerschemedetails extends StatefulWidget {
  static String routeName = "/Customerschemedetails";
  @override
  _CustomerschemedetailsState createState() => _CustomerschemedetailsState();
}

class _CustomerschemedetailsState extends State<Customerschemedetails> {
  int subid;
  List<int> subidlist = new List();

  int role;

  getrole() async {
    role = await getSavedObject("roleid");
    print(role.toString());
  }

  @override
  void initState() {
    super.initState();
    getScheme();
  }

  Subscriptionlistmodel data = new Subscriptionlistmodel();
  @override
  Widget build(BuildContext context) {
    //   getrole();
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: data.data != null
          ? Column(
              children: [
                // Text(data.data.subscriptionList.length.toString()),
                Expanded(
                  child: data.data.subscriptionList.isEmpty
                      ? Center(
                          child: Text(
                          "This customer dont have any scheme",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          textAlign: TextAlign.center,
                        ))
                      : ListView.builder(
                          itemCount: data.data.subscriptionList.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor("#E3E3E3"),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: InkWell(
                                  onTap: () async {
                                    await saveObject("subscription",
                                        subidlist.elementAt(index));

                                    print("select sub id" +
                                        subidlist.elementAt(index).toString());
                                    Navigator.pushNamed(
                                        context, HomeTabs.routeName);
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
                                            Text(data.data.subscriptionList
                                                .elementAt(index)
                                                .schemeName
                                                .toString()),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            data.data.subscriptionList
                                                        .elementAt(index)
                                                        .subscriptionType ==
                                                    0
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            HexColor("#720755"),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 7.0,
                                                        right: 7,
                                                      ),
                                                      child: Text(
                                                        rs +
                                                            data.data
                                                                .subscriptionList
                                                                .elementAt(
                                                                    index)
                                                                .schemAmount
                                                                .toString()
                                                                .split('.')[0],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  )
                                                : Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: HexColor(
                                                                "#720755"),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 7.0,
                                                            right: 7,
                                                          ),
                                                          child: Text(
                                                            rs +
                                                                data.data
                                                                    .subscriptionList
                                                                    .elementAt(
                                                                        index)
                                                                    .schemAmount
                                                                    .toString()
                                                                    .split(
                                                                        '.')[0],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        " To ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: HexColor(
                                                                "#720755"),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 7.0,
                                                            right: 7,
                                                          ),
                                                          child: Text(
                                                            rs +
                                                                data.data
                                                                    .subscriptionList
                                                                    .elementAt(
                                                                        index)
                                                                    .amountTo
                                                                    .toString()
                                                                    .split(
                                                                        '.')[0],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                          ],
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_forward_ios_outlined)
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
            )
          : Container(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, SelectPackage.routeName)
                .then((value) => getScheme());
          },
          label: const Text(
            'New Scheme',
            style: TextStyle(color: Colors.black),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: accentClr),
    );
  }

  Future<void> getScheme() async {
    int userid;
    subidlist.clear();
    try {
      EasyLoading.show(status: 'Loading...');
      //    showLoading(context);

      if (await getSavedObject("roleid") == 3) {
        userid = await getSavedObject("customerid");
      } else {
        userid = await getSavedObject("userid");
      }

      // userid = role != 2
      //     ? await getSavedObject("customerid")
      //     : await getSavedObject("userid");

      print("dfbasdfbdsfhdbfdf " + role.toString());
      print("dfbasdfbdsfhdbfdf " + userid.toString());
      print(await getSavedObject("customerid"));
      print(await getSavedObject("userid"));
      Subscriptionlistmodel datas =
          await Schemelistgetservice.getScheme(userid);
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      EasyLoading.dismiss();
      setState(() {
        data = datas;
        print(data);
        //  test();
      });
      data.data.subscriptionList.forEach((element) {
        subidlist.add(element.id);
      });
    } catch (e) {
      // showErrorMessage(e);
      EasyLoading.dismiss();
      //  Navigator.pop(context);
    }
  }
}
