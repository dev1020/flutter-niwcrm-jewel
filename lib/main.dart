import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:niwcrm_jewel/pages/companyCustomers.dart';
import 'package:niwcrm_jewel/pages/dashboardpage.dart';
import 'package:niwcrm_jewel/pages/newSale.dart';
import 'package:niwcrm_jewel/utils/customColors.dart';

import 'package:niwcrm_jewel/pages/allSales.dart';

void main() => runApp(NiwcrmJewel());

class NiwcrmJewel extends StatefulWidget {
  NiwcrmJewel({Key key}) : super(key: key);

  _NiwcrmJewelState createState() => _NiwcrmJewelState();
}

class _NiwcrmJewelState extends State<NiwcrmJewel> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //top bar color
      ),
    );
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: CustomColors.GreyBackground,
        fontFamily: 'rubik',
      ),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => DashBoard(),
        '/newSale': (context) => NewSaleScreen(),
        '/allSales': (context) => AllSalesScreen(),
        '/companyCustomers': (context) => CompanyCustomersScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
    );
  }
}
