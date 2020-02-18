import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:niwcrm_jewel/models/dashBoardModel.dart';
import 'package:niwcrm_jewel/widgets/appBars.dart';
import 'package:niwcrm_jewel/widgets/bottomNavigation.dart';
import 'package:niwcrm_jewel/widgets/fab.dart';
import 'package:niwcrm_jewel/widgets/dashboarddrawer.dart';
import 'package:niwcrm_jewel/utils/customColors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:niwcrm_jewel/pages/createOrder.dart';
import 'package:niwcrm_jewel/utils/network_utils.dart';
import 'dart:convert';
//import 'package:niwcrm_jewel/widgets/bottomSheet.dart';

class ClicksPerYear {
  final String year;
  final int clicks;

  ClicksPerYear(this.year, this.clicks);
}

class NewCustomersPerMonth {
  final String month;
  final int number;
  NewCustomersPerMonth(this.month, this.number);
}

class CustomersVisitedPerMonth {
  final String month;
  final int number;
  CustomersVisitedPerMonth(this.month, this.number);
}

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with TickerProviderStateMixin {
  var bottomNavigationBarIndex = 0;
  CreateOrder createOrder = CreateOrder();
  DashBoardModel dashBoardModel;
  bool isloaded = false;
  AnimationController controller;
  Animation<double> animation;

  fetchdashboardDetails() async {
    print(1);
    //Fetch nodes from server if no nodes are present in local database
    var endpoint = 'dashboards?company_id=11&';
    var responseJson =
        await NetworkUtils.fetch('oI0J-0hrZxdhR2AQitd3tAPoQzlCWPtx', endpoint);
    //print(responseJson[0]['sos_reciever_nick_name']);
    var responseJsonBody = json.decode(responseJson.body);
    print(responseJsonBody);
    DashBoardModel getdashBoardModel =
        DashBoardModel.fromJson(responseJsonBody);

    setState(() {
      dashBoardModel = getdashBoardModel;
      isloaded = true;
      
    });
  }

  @override
  void initState() {
    fetchdashboardDetails();
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    //fetchdashboardDetails();
    print(2);
    var data = [
      new ClicksPerYear(
        'Jan',
        125,
      ),
      new ClicksPerYear(
        'Feb',
        424,
      ),
      new ClicksPerYear(
        'Mar',
        504,
      ),
      new ClicksPerYear(
        'April',
        650,
      ),
      new ClicksPerYear(
        'May',
        250,
      ),
      new ClicksPerYear(
        'Jun',
        850,
      ),
      new ClicksPerYear(
        'July',
        580,
      ),
      new ClicksPerYear(
        'Aug',
        450,
      ),
      new ClicksPerYear(
        'Sep',
        650,
      ),
      new ClicksPerYear(
        'Oct',
        750,
      ),
      new ClicksPerYear(
        'Nov',
        0,
      ),
      new ClicksPerYear(
        'Dec',
        0,
      ),
    ];
    var newCustomers = [
      new NewCustomersPerMonth(
        'Jan',
        125,
      ),
      new NewCustomersPerMonth(
        'Feb',
        424,
      ),
      new NewCustomersPerMonth(
        'Mar',
        504,
      ),
      new NewCustomersPerMonth(
        'April',
        650,
      ),
      new NewCustomersPerMonth(
        'May',
        250,
      ),
      new NewCustomersPerMonth(
        'Jun',
        850,
      ),
      new NewCustomersPerMonth(
        'July',
        580,
      ),
      new NewCustomersPerMonth(
        'Aug',
        450,
      ),
      new NewCustomersPerMonth(
        'Sep',
        650,
      ),
      new NewCustomersPerMonth(
        'Oct',
        750,
      ),
      new NewCustomersPerMonth(
        'Nov',
        0,
      ),
      new NewCustomersPerMonth(
        'Dec',
        0,
      ),
    ];
    var customersVisited = [
      new CustomersVisitedPerMonth(
        'Jan',
        125,
      ),
      new CustomersVisitedPerMonth(
        'Feb',
        424,
      ),
      new CustomersVisitedPerMonth(
        'Mar',
        504,
      ),
      new CustomersVisitedPerMonth(
        'April',
        650,
      ),
      new CustomersVisitedPerMonth(
        'May',
        250,
      ),
      new CustomersVisitedPerMonth(
        'Jun',
        850,
      ),
      new CustomersVisitedPerMonth(
        'July',
        580,
      ),
      new CustomersVisitedPerMonth(
        'Aug',
        450,
      ),
      new CustomersVisitedPerMonth(
        'Sep',
        650,
      ),
      new CustomersVisitedPerMonth(
        'Oct',
        750,
      ),
      new CustomersVisitedPerMonth(
        'Nov',
        0,
      ),
      new CustomersVisitedPerMonth(
        'Dec',
        0,
      ),
    ];

    var series = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
    );
    var chartWidget = new Padding(
      padding: new EdgeInsets.all(0.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    var groupedseries = [
      new charts.Series(
        domainFn: (NewCustomersPerMonth data, _) => data.month,
        measureFn: (NewCustomersPerMonth data, _) => data.number,
        id: 'Clicks',
        data: newCustomers,
      ),
      new charts.Series(
        domainFn: (CustomersVisitedPerMonth data, _) => data.month,
        measureFn: (CustomersVisitedPerMonth data, _) => data.number,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        id: 'Clicks',
        data: customersVisited,
      ),
    ];

    var groupedchart = new charts.BarChart(
      groupedseries,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
    );
    var groupedchartWidget = new Padding(
      padding: new EdgeInsets.all(0.0),
      child: new SizedBox(
        height: 200.0,
        child: groupedchart,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: emptyAppbar('DashBoard | Maa Durga Jewellers'),
      drawer: DashBoardDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        width: MediaQuery.of(context).size.width,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => Container(
                      margin: EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              contentPadding: EdgeInsets.all(0.0),
                              //leading: Icon(Icons.search),
                              trailing: RaisedButton(
                                color: CustomColors.GreenDark,
                                onPressed: () {},
                                child: Text(
                                  'Search',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: TextField(
                                decoration: InputDecoration(
                                    hintStyle:
                                        TextStyle(fontStyle: FontStyle.italic),
                                    hintText:
                                        "Customer Name, Number or Order No"),
                              ),
                            ),
                          ],
                        ),
                      )),
                  childCount: 1),
            ),
            isloaded ? loadContainers() : loadercontainer(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => Container(
                      margin: EdgeInsets.all(10.0),
                      child: Container(
                          child: Column(
                        children: <Widget>[
                          Text('Sales Figure',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              )),
                          chartWidget,
                          SizedBox(height: 10),
                          Divider(
                            height: 1,
                          ),
                          SizedBox(height: 10),
                          Text('Customers',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              )),
                          groupedchartWidget,
                          Container(
                            height: 40,
                          )
                        ],
                      ))),
                  childCount: 1),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(context, createOrder),
      bottomNavigationBar:
          BottomNavigationBarApp(context, bottomNavigationBarIndex),
    );
  }

  loadercontainer() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => Container(
              margin: EdgeInsets.all(10.0),
              child: Container(
                  child: Card(
                child: Image(
                  image: AssetImage("assets/loader.gif"),
                ),
              ))),
          childCount: 1),
    );
  }

  loadContainers() {
    return SliverGrid.count(
      crossAxisCount: 2,
      children: [
        dashBoardContainers(
            Icon(FontAwesomeIcons.rupeeSign),
            dashBoardModel.getTodaysSale.toString(),
            "Today\'s Sale",
            "More Info",
            Colors.green[300],
            Colors.green[900],
            Colors.white70),
        dashBoardContainers(
            Icon(FontAwesomeIcons.rupeeSign),
            dashBoardModel.getLatestOrder.toString(),
            "Latest Order",
            "View It",
            Colors.pink[300],
            Colors.pink[900],
            Colors.white70),
        dashBoardContainers(null, dashBoardModel.getcancelledOrder.toString(), "Cancelled Order", "View It",
            Colors.red[300], Colors.red[900], Colors.white70),
        dashBoardContainers(
            Icon(FontAwesomeIcons.rupeeSign),
            dashBoardModel.getSaleThisMonth.toString(),
            "Order This Month",
            "Visit Orders",
            Colors.purple[300],
            Colors.purple[800],
            Colors.white70),
        dashBoardContainers(
            Icon(FontAwesomeIcons.users),
            dashBoardModel.getNewCustomers.toString()+ " / " +dashBoardModel.getAllCustomers.toString(),
            "Customers",
            "Manage Customers",
            Colors.blue[300],
            Colors.blue[900],
            Colors.white70),
        dashBoardContainers(
            Icon(Icons.hourglass_full),
            dashBoardModel.getApprovalPending.toString()+" Orders",
            "Need Approval",
            "Pending Orders",
            Colors.orange[300],
            Colors.orange[900],
            Colors.white70),
      ],
    );
  }

  dashBoardContainers(
    Icon topicon,
    String toplabel,
    String middlelabel,
    String bottomlabel,
    Color gradientstartcolor,
    Color gradientendcolor,
    Color buttoncolor,
    //[int duration]
  ) {
    return Container(
        child: Center(
          child: FadeTransition(
            opacity: animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      (topicon != null) ? topicon : Container(),
                      AutoSizeText(
                        toplabel,
                        maxFontSize: 30,
                        style: TextStyle(
                            color: CustomColors.TextWhite,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                AutoSizeText(
                  middlelabel,
                  maxFontSize: 20.0,
                  style: TextStyle(
                      color: CustomColors.TextWhite,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  // height: double.infinity,
                  child: FlatButton(
                    onPressed: () => {},
                    color: buttoncolor,
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        AutoSizeText(
                          bottomlabel,
                          maxFontSize: 12,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        SizedBox(width: 1),
                        Icon(FontAwesomeIcons.solidArrowAltCircleRight),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [gradientstartcolor, gradientendcolor]),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: CustomColors.GreyBorder,
              blurRadius: 10.0,
              spreadRadius: 5.0,
              offset: Offset(0.0, 0.0),
            ),
          ],
          color: Colors.white,
        ),
        margin: EdgeInsets.all(10),
        height: 150.0);
  }
}
