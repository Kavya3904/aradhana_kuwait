import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/screens/PDF/PdfView.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future loginDrawer(context) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: appbarClr,
      context: context,
      isScrollControlled: true,
      builder: (context) => Stack(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  h(MediaQuery.of(context).size.height * 0.05),
                  tile(FontAwesomeIcons.bullhorn, "Promoters", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pdfView(),
                      ),
                    );
                  }),

                  // divvv(),
                  // tile(Icons.video_collection_sharp, "How To Use", () {
                  //   Navigator.pushNamed(context, videoPage.routeName);
                  // }),
                  // divvv(),
                  // tile(Icons.info_outline, "About Us", () {
                  //   Navigator.pushNamed(context, Aboutus.routeName);
                  // }),61
                  // tile(Icons.lock, "Privacy policy", () {
                  //   Navigator.pushNamed(context, PrivacyPolicy.routeName);
                  // }),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        top: 50),
                  ),
                ],
              ),
            ),
          ]));
}

Widget tile(IconData icon, String txt, GestureTapCallback onTap) {
  return ListTile(
    dense: true,
    contentPadding: EdgeInsets.zero,
    title: Text(txt.toUpperCase(),
        style: TextStyle(color: Colors.white, fontSize: 13)),
    leading: Icon(icon, color: Colors.white, size: 22),
    onTap: onTap,
  );
}

Widget divvv() {
  return Divider(color: Colors.white54, endIndent: 40, indent: 40);
}
