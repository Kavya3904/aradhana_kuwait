import 'dart:io';

//hg b
import 'package:aradhana/Constants/Constants.dart';
import 'package:aradhana/Screenagent/Agentprofile/agentprofile.dart';
import 'package:aradhana/Screenagent/Customerplans/Customerdetails.dart';
import 'package:aradhana/Screenagent/Customerplans/Customerschemedetails.dart';
import 'package:aradhana/Screenagent/homescreen/agentab.dart';
import 'package:aradhana/Screenagent/homescreen/agentdashboard.dart';
import 'package:aradhana/Screenagent/homescreen/agenthomescreen.dart';
import 'package:aradhana/Util/videoPage.dart';
import 'package:aradhana/Widget/Updatescreen.dart';
import 'package:aradhana/screens/Aboutus/About.dart';
import 'package:aradhana/screens/HomeScreen/Dashboard.dart';
import 'package:aradhana/screens/HomeScreen/Dashboardhome.dart';
import 'package:aradhana/screens/HomeScreen/Dashboardlogin.dart';
import 'package:aradhana/screens/HomeScreen/HomeScreen.dart';
import 'package:aradhana/screens/HomeScreen/HomeTab.dart';
import 'package:aradhana/screens/HomeScreen/SelectShemehomepage.dart';
import 'package:aradhana/screens/Login/Login.dart';
import 'package:aradhana/screens/MyPackage/ViewPaidList.dart';
import 'package:aradhana/screens/MyPackage/ViewPendingList.dart';
import 'package:aradhana/screens/MyPackage/choosepaymentOptionPage.dart';
import 'package:aradhana/screens/Notifications/Notification.dart';
import 'package:aradhana/screens/Otp/Otpscreen_copy.dart';
import 'package:aradhana/screens/PDF/PdfView.dart';
import 'package:aradhana/screens/Packageselect/PriceSelect/PriceSelecttab.dart';
import 'package:aradhana/screens/Packageselect/PriceSelect/yearlyscheme.dart';
import 'package:aradhana/screens/Packageselect/Selectpackage.dart';
import 'package:aradhana/screens/Packageselect/Selectpackagefirsttime.dart';
import 'package:aradhana/screens/PaymentGateway/paymentSuccessScreen.dart';
import 'package:aradhana/screens/Paymentsendscreen/Paymentscreen.dart';
import 'package:aradhana/screens/Profile/Profile.dart';
import 'package:aradhana/screens/Recepit/Recepit.dart';
import 'package:aradhana/screens/Referralcode/Referral.dart';
import 'package:aradhana/screens/Registrationpage/Registration.dart';
import 'package:aradhana/screens/Registrationpage/Registrationfirst.dart';
import 'package:aradhana/screens/Splash/Splashscreen.dart';
import 'package:aradhana/screens/Splash/splashScreen2.dart';
import 'package:aradhana/screens/TermsCondition/terms&cond.dart';
import 'package:aradhana/screens/VideoScreen/videoScreen.dart';
import 'package:aradhana/screens/Wallet/Wallet.dart';
import 'package:aradhana/screens/Wholewallet/Singleschemedetails.dart';
import 'package:aradhana/screens/Wholewallet/wholewallet.dart';
import 'package:aradhana/screens/pdfview/brochure.dart';
import 'package:aradhana/screens/teams/teams.dart';
import 'package:aradhana/service/PushNotificationService.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:aradhana/service/PushNotificationService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Screenagent/Agentregistration/Agenstregistration.dart';
import 'Screenagent/Paymentdetails/Pendingpaymentdetials.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.clear
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final pushNotificationService =
        PushNotificationService(FirebaseMessaging.instance);
    pushNotificationService.initialise();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    const MaterialColor kPrimaryColor = const MaterialColor(
      0xFF872572,
      const <int, Color>{
        50: const Color(0xFF260305),
        100: const Color(0xFF260305),
        200: const Color(0xFF260305),
        300: const Color(0xFF260305),
        400: const Color(0xFF260305),
        500: const Color(0xFF260305),
        600: const Color(0xFF260305),
        700: const Color(0xFF260305),
        800: const Color(0xFF260305),
        900: const Color(0xFF260305),
      },
    );
    return FirebasePhoneAuthProvider(
      child: MaterialApp(
        title: titleSmall,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: bgClr,
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: appbarClr),
          appBarTheme: AppBarTheme(
              elevation: 2,
              shadowColor: accentClr,
              backgroundColor: appbarClr,
              iconTheme: IconThemeData(color: iconClr)),
          fontFamily: 'Lato',
          primarySwatch: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: HexColor("#720755"),
          unselectedWidgetColor: Colors.white,
        ),
        initialRoute: Splashscreen.routeName,
        routes: {
          Splashscreen.routeName: (context) => Splashscreen(),
          Otpscreen.routeName: (context) => Otpscreen(),
          Login.routeName: (context) => Login(),
          Registration.routeName: (context) => Registration(),
          Registerationsecond.routeName: (context) => Registerationsecond(),
          SelectPackage.routeName: (context) => SelectPackage(),
          SelectpriceTab.routeName: (context) => SelectpriceTab(),
          HomeScreen.routeName: (context) => HomeScreen(),
          HomeTabs.routeName: (context) => HomeTabs(),
          // MyPackage.routeName: (context) => MyPackage(),
          Wallet.routeName: (context) => Wallet(),
          Profile.routeName: (context) => Profile(),
          SelectScheme.routeName: (context) => SelectScheme(),
          Agenthomescreen.routeName: (context) => Agenthomescreen(),
          Agenstregistration.routeName: (context) => Agenstregistration(),
          Selectpackagefirsttime.routeName: (context) =>
              Selectpackagefirsttime(),
          Customerschemedetails.routeName: (context) => Customerschemedetails(),
          Customerdetails.routeName: (context) => Customerdetails(),
          Notifications.routeName: (context) => Notifications(),
          Agentprofile.routeName: (context) => Agentprofile(),
          Agentab.routeName: (context) => Agentab(),
          Update.routeName: (context) => Update(),
          Referral.routeName: (context) => Referral(),
          Aboutus.routeName: (context) => Aboutus(),
          Recepit.routeName: (context) => Recepit(),
          //Razorpayui.routeName:(context)=>Razorpayui(),
          PendingPayment.routeName: (context) => PendingPayment(),
          Paymentscreen.routeName: (context) => Paymentscreen(),
          Dashboardlogin.routeName: (context) => Dashboardlogin(),
          Dashboard.routeName: (context) => HomeScreen(),
          Brochure.routeName: (context) => Brochure(),
          Wholewallet.routeName: (context) => Wholewallet(),
          Singleschemedetails.routeName: (context) => Singleschemedetails(),
          Dashboardhome.routeName: (context) => Dashboardhome(),
          AgentDashboardhome.routeName: (context) => AgentDashboardhome(),
          SelectpriceTabyearly.routeName: (context) => SelectpriceTabyearly(),
          Teams.routeName: (context) => Teams(),
          ListViews.routeName: (context) => ListViews(),
          UpcomingPaymentList.routeName: (context) => UpcomingPaymentList(),
          SplashScreen2.routeName: (context) => SplashScreen2(),
          videoScreen.routeName: (context) => videoScreen(),
          paymentSuccessScreen.routeName: (context) => paymentSuccessScreen(),
          pdfView.routeName: (context) => pdfView(),
          choosepaymentOption.routeName: (context) => choosepaymentOption(),
          videoPage.routeName: (context) => videoPage(),
          termsCondition.routeName: (context) => termsCondition(),
        },
        builder: (context, myWidget) {
          // do your initialization here
          // myWidget = EasyLoading.init() as Widget;  // assuming this is returning a widget
          // myWidget = botToastBuilder(context,child);
          myWidget = EasyLoading.init()(context, myWidget);

          return MediaQuery(
            child: myWidget,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.1),
          );
          // return myWidget;
        },
      ),
    );
  }
}
