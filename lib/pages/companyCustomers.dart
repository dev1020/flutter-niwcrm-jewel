import 'package:flutter/material.dart';
import 'package:niwcrm_jewel/models/customerStatsModel.dart';
import 'package:niwcrm_jewel/widgets/appBars.dart';
import 'package:niwcrm_jewel/widgets/bottomNavigation.dart';
import 'package:niwcrm_jewel/widgets/fab.dart';
import 'package:niwcrm_jewel/widgets/dashboarddrawer.dart';
import 'package:niwcrm_jewel/pages/createOrder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'dart:async';
import 'package:shimmer/shimmer.dart';
import 'package:niwcrm_jewel/models/companyCustomersModel.dart';
import 'package:niwcrm_jewel/utils/network_utils.dart';
import 'dart:convert';
import 'package:badges/badges.dart';

class CompanyCustomersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CompanyCustomersScreenState();
  }
}

class CompanyCustomersScreenState extends State<CompanyCustomersScreen> {
  var bottomNavigationBarIndex = 0;
  CreateOrder createOrder = CreateOrder();
  int pagenum = 1;
  List<CompanyCustomersModel> itemlist;
  ScrollController _scrollcontroller;

  List _selectedItems = List();
  bool _loadingInProgress = true;
  bool bottomloading = false;

  int countDataTablePage,
      countDataTableItems,
      countDataTableItemsPerPage,
      dataTableCurrentPage;

  @override
  void initState() {
    _scrollcontroller = ScrollController();
    _scrollcontroller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_scrollcontroller.offset >=
            _scrollcontroller.position.maxScrollExtent &&
        !_scrollcontroller.position.outOfRange) {
      print("REach Bottom");
      setState(() {
        pagenum = pagenum + 1;
        //_loadingInProgress = true;
        bottomloading = true;
      });
      _fetchNext();
    }
    if (_scrollcontroller.offset <=
            _scrollcontroller.position.minScrollExtent &&
        !_scrollcontroller.position.outOfRange) {
      print("REach Top");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (itemlist == null) {
      itemlist = List<CompanyCustomersModel>();
      _fetchlist();
    }

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: false,
      appBar: emptyAppbar('Company Customers| Maa Durga Jewellers'),
      drawer: DashBoardDrawer(),
      body: _loadingInProgress
          ? Center(
              //height: MediaQuery.of(context).size.height,
              //width:MediaQuery.of(context).size.width,
              child: Shimmer.fromColors(
                child: Image(
                  image: new AssetImage("assets/listloader.png"),
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  // height: 500,
                ),
                baseColor: Colors.grey[100],
                highlightColor: Colors.grey[400],
              ),
            )
          : Stack(
              children: <Widget>[
                getCustomerlistView(),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(context, createOrder),
      bottomNavigationBar:
          BottomNavigationBarApp(context, bottomNavigationBarIndex),
    );
  }

  getCustomerlistView() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.indigo[800],
          child: ListTile(
            leading: Checkbox(value: true, onChanged: (bool value) {}),
            title: Text('Customer Name',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    return true;
                  },
                ),
                IconButton(
                  icon: Icon(Icons.sort_by_alpha, color: Colors.white),
                  onPressed: () {
                    return true;
                  },
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              controller: _scrollcontroller,
              itemCount: itemlist.length,
              itemBuilder: (BuildContext context, int position) {
                return Card(
                    color:
                        (position % 2 == 0) ? Colors.grey[200] : Colors.white,
                    child: ExpansionTile(
                      onExpansionChanged:(bool value){
                        getDetails(value,itemlist[position]);
                      },
                      leading: Checkbox(
                        value: _selectedItems
                            .contains(itemlist[position].getCustomerId),
                        onChanged: (bool value) {
                          _onCategorySelected(
                              value, itemlist[position].getCustomerId);
                        },
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              itemlist[position].getCustomerName.toUpperCase()),
                          (DateTime.now()
                                      .difference(DateTime.parse(
                                          itemlist[position]
                                              .getCustomerCreatedDate))
                                      .inDays <
                                  100)
                              ? Badge(
                                  badgeColor: Colors.green[900],
                                  shape: BadgeShape.square,
                                  borderRadius: 20,
                                  toAnimate: false,
                                  badgeContent: Text('NEW',
                                      style: TextStyle(color: Colors.white)),
                                )
                              : Container(),
                        ],
                      ),
                      children: <Widget>[
                        customerStats(itemlist[position])
                      ],
                    ));
              }),
        ),
        bottomloader(),
      ],
    );
  }
  getDetails(bool value,listitem) async {
    if(value){
      _fetchCustomerStats(listitem);
    }else{
      print('collapsed');
    }
  }
  customerStats(listitem){
    var textStyle = TextStyle(fontSize: 15,fontWeight: FontWeight.w500,);
    var valueTextStyle = TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w500);

    if(listitem.customerStats ==null)
    {
      return Card(child: LinearProgressIndicator());
    }else{
      return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Divider(),
              Container(
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Name:',style: textStyle,),
                          Text(listitem.getCustomerName , style:valueTextStyle),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Contact:',style: textStyle,),
                          Text(listitem.getCustomerContact,style:valueTextStyle),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
              Container(
                width: 200,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Points Available:-',style: textStyle,),
                          Text(listitem.customerStats.getCustomerTotalPoints.toString(),style:TextStyle(color: Colors.green[800],fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: <Widget>[
                          Text('Total Order Value:-',style: textStyle),
                          Text(listitem.customerStats.getCustomerTotalOrderValue.toString(),style:valueTextStyle),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: <Widget>[
                          Text('Due Amount:-',style: textStyle,),
                          Text(listitem.customerStats.getCustomerTotalDue.toString(),style:TextStyle(color: Colors.red[800],fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
          ),
        ),
         Divider(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: (listitem.customerStats.orders!=null)? DataTable(
            columnSpacing: 20.0,
            columns: [
              DataColumn(
                label: Text('Order Date'),
                numeric: false,
              ),
              DataColumn(
                label: Text('Total Value'),
                numeric: false,
              ),
              DataColumn(
                label: Text('Status'),
                numeric: false,
              ),
            ],
            rows: orderTableList(listitem.customerStats.orders),
          ):Container(),
        )
      ],
    );
    }
    
  }

  orderTableList(orders) {
    List<DataRow> orderRowList = [];
    // print(orders[0].orderDate);

    if (orders !=null && orders.length > 0) {
      for (int i = 0; i < orders.length; i++) {
        DataRow orderRow = DataRow(cells: [
          DataCell(Text(orders[i].orderDate)),
          DataCell(Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(FontAwesomeIcons.rupeeSign, size: 15),
              Text(orders[i].totalAmount),
            ],
          )),
          DataCell(Badge(
            badgeColor: (orders[i].status == 'completed')
                ? Colors.green[900]
                : Colors.red[800],
            shape: BadgeShape.square,
            borderRadius: 20,
            toAnimate: false,
            badgeContent: Text(
                (orders[i].status == 'completed')
                    ? 'Completed'
                    : 'Due ' + orders[i].dueAmount,
                style: TextStyle(color: Colors.white)),
          )),
          //DataCell(Text(orders[i].dueAmount)),
        ]);
        orderRowList.add(orderRow);
      }
    } else {
      DataRow orderRow = DataRow(cells: [
        DataCell(Text('No Orders')),
        DataCell(Text('To Display')),
        
        DataCell(Text('To Display')),
      ]);
      orderRowList.add(orderRow);
    }
    return orderRowList;
  }

  bottomloader() {
    if (bottomloading) {
      return Card(
        child: LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green[800]),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      return Container();
    }
  }

  void _onCategorySelected(bool selected, customerId) {
    if (_selectedItems.length > 0) {}
    if (selected == true) {
      setState(() {
        _selectedItems.add(customerId);
      });
    } else {
      setState(() {
        _selectedItems.remove(customerId);
      });
    }
  }

  _fetchlist() async {
    List<CompanyCustomersModel> datatablelist = [];

    //Fetch nodes from server if no nodes are present in local database
    CompanyCustomersModel datatableitem;
    var endpoint = 'companycustomers?company_id=11&expand=cust,orders&';
    var responseJson =
        await NetworkUtils.fetch('oI0J-0hrZxdhR2AQitd3tAPoQzlCWPtx', endpoint);
    //print(responseJson[0]['sos_reciever_nick_name']);
    var responseJsonBody = json.decode(responseJson.body);
    for (int i = 0; i < responseJsonBody.length; i++) {
      datatableitem = CompanyCustomersModel.fromJson(responseJsonBody[i]);

      datatablelist.add(datatableitem);
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        itemlist = datatablelist;
        _loadingInProgress = false;
      });
    });
  }

  _fetchNext() async {
    List<CompanyCustomersModel> datatablelist = [];

    //Fetch nodes from server if no nodes are present in local database
    CompanyCustomersModel datatableitem;
    var endpoint =
        'companycustomers?page=$pagenum&company_id=13&expand=cust,orders&';
    var responseJson =
        await NetworkUtils.fetch('oI0J-0hrZxdhR2AQitd3tAPoQzlCWPtx', endpoint);
    //print(responseJson[0]['sos_reciever_nick_name']);
    var responseJsonBody = json.decode(responseJson.body);
    for (int i = 0; i < responseJsonBody.length; i++) {
      datatableitem = CompanyCustomersModel.fromJson(responseJsonBody[i]);

      datatablelist.add(datatableitem);
    }
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        itemlist = List.from(itemlist)..addAll(datatablelist);
        _loadingInProgress = false;
        bottomloading = false;
      });
    });
  }

  _fetchCustomerStats(listitem) async {
    var id = listitem.getCustomerId;
      var endpoint =
        'companycustomers/stats?company_id=11&customer_id=$id';
    var responseJson =
        await NetworkUtils.fetch('oI0J-0hrZxdhR2AQitd3tAPoQzlCWPtx', endpoint);
    //print(responseJson[0]['sos_reciever_nick_name']);
    var responseJsonBody = json.decode(responseJson.body);
    print(responseJsonBody);
    setState(() {
      listitem.customerStats =  CustomerStats.fromJson(responseJsonBody);
    });

  }
}
