import 'package:flutter/material.dart';

import 'package:niwcrm_jewel/widgets/appBars.dart';

import 'package:niwcrm_jewel/widgets/dashboarddrawer.dart';
import 'package:niwcrm_jewel/pages/createOrder.dart';

class NewSaleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewSaleScreenState();
  }
}

class NewSaleScreenState extends State<NewSaleScreen> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: false,
      appBar: emptyAppbar('New Sale | Maa Durga Jewellers'),
      drawer: DashBoardDrawer(),
      body: CreateOrder()
    );
  }

  
}
