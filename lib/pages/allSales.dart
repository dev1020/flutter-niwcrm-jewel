import 'package:flutter/material.dart';
//import 'package:data_tables/data_tables.dart';
import 'package:niwcrm_jewel/widgets/appBars.dart';
import 'package:niwcrm_jewel/widgets/bottomNavigation.dart';
import 'package:niwcrm_jewel/widgets/fab.dart';
import 'package:niwcrm_jewel/widgets/dashboarddrawer.dart';
import 'package:niwcrm_jewel/pages/createOrder.dart';
import 'package:niwcrm_jewel/models/ordersModel.dart';
import 'package:niwcrm_jewel/utils/network_utils.dart';
import 'dart:convert';
import 'package:niwcrm_jewel/utils/synScrollContainer.dart';
import 'package:badges/badges.dart';

class AllSalesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllSalesScreenState();
  }
}

class AllSalesScreenState extends State<AllSalesScreen> {
  var bottomNavigationBarIndex = 0;
  CreateOrder createOrder = CreateOrder();
  List<OrderModel> orderList;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  bool isLoading = true;

  ScrollController firstScroller = new ScrollController();
  ScrollController secondScroller = new ScrollController();
  SyncScrollController syncScroller;

  OrdersDataSource companyCustomersSource = OrdersDataSource();
  @override
  void initState() {
    syncScroller = new SyncScrollController([firstScroller, secondScroller]);
    super.initState();
    //_fetchlist();
    setState(() {
      print(133);
    });
  }

  _fetchlist() async {
    List<OrderModel> datatablelist = [];

    //Fetch nodes from server if no nodes are present in local database
    OrderModel datatableitem;
    var endpoint = 'orders/allsales?company_id=&expand=cust&';
    var responseJson =
        await NetworkUtils.fetch('oI0J-0hrZxdhR2AQitd3tAPoQzlCWPtx', endpoint);
    //print(responseJson[0]['sos_reciever_nick_name']);
    var responseJsonBody = json.decode(responseJson.body);
    var responseJsonhead = (responseJson.headers);
    for (int i = 0; i < responseJsonBody.length; i++) {
      datatableitem = OrderModel.fromJson(responseJsonBody[i]);
      // print(datatableitem.getTotalAmount);
      datatablelist.add(datatableitem);
    }

    setState(() {
      orderList = datatablelist;
      isLoading = false;
      print(orderList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (orderList == null) {
      orderList = List<OrderModel>();
      _fetchlist();
    }

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: false,
      appBar: emptyAppbar('All Orders | Maa Durga Jewellers'),
      drawer: DashBoardDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : mylistview(
              context, firstScroller, secondScroller, syncScroller, orderList),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(context, createOrder),
      bottomNavigationBar:
          BottomNavigationBarApp(context, bottomNavigationBarIndex),
    );
  }

  showDatatablew() {
    return PaginatedDataTable(
      header: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('All Sales'),
          Divider(
            thickness: 5,
            color: Colors.blue,
          ),
        ],
      ),
      rowsPerPage: _rowsPerPage,
      //columnSpacing: 10,
      // horizontalMargin:10,
      headingRowHeight: 40,
      onRowsPerPageChanged: (int value) {
        setState(() {
          _rowsPerPage = value;
        });
      },
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _sortAscending,
      onSelectAll: companyCustomersSource._selectAll,
      columns: <DataColumn>[
        DataColumn(
          label: const Text('Order Date'),
        ),
        DataColumn(
          label: const Text('Amount'),
        ),
        DataColumn(
          label: const Text('Status'),
        ),
        DataColumn(
          label: const Text('Created Date'),
        ),
      ],
      source: companyCustomersSource,
    );
  }
}

mylistview(
    BuildContext context,
    ScrollController firstScroller,
    ScrollController secondScroller,
    SyncScrollController syncScroller,
    List<OrderModel> orderList) {
  var headertextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
  return Stack(
    children: [
      Positioned(
        width: MediaQuery.of(context).size.width,
        height: 50,
        top: 0,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            syncScroller.processNotification(scrollInfo, firstScroller);
          },
          child: SingleChildScrollView(
            controller: firstScroller,
            scrollDirection: Axis.horizontal,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown[900],
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Checkbox(
                        value: true,
                        onChanged: (bool value) {
                          return value = !value;
                        },
                      ),
                    ),
                    Container(
                        width: 100,
                        child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              'Order Date ',
                              style: headertextStyle,
                            ))),
                    Container(
                        width: 100,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  'Amount',
                                  style: headertextStyle,
                                )))),
                    Container(
                        width: 200,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  'Customer',
                                  style: headertextStyle,
                                )))),
                    Container(
                        width: 100,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  'Invoice ',
                                  style: headertextStyle,
                                )))),
                    Container(
                        width: 100,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  'Status',
                                  style: headertextStyle,
                                )))),
                    Container(
                        width: 200,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  'Note',
                                  style: headertextStyle,
                                )))),
                    
                  ],
                )),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 50),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            syncScroller.processNotification(scrollInfo, secondScroller);
          },
          child: SingleChildScrollView(
            controller: secondScroller,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 850,
              child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (BuildContext context, int position) {
                  var cellTextStyle = TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  );
                  return Container(
                    height: 75,
                    decoration: BoxDecoration(
                        color: (position % 2 == 0)
                            ? Colors.grey[200]
                            : Colors.white,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: (orderList[position].status == 'completed')
                              ? [Colors.green[100], Colors.green[300]]
                              : [Colors.orange[100], Colors.orange[300]],
                        ),
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.brown[900], width: 2))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 50,
                          child: Checkbox(
                            activeColor: Colors.purple[800],
                            value: true,
                            onChanged: (bool value) {
                              return value = !value;
                            },
                          ),
                        ),
                        Container(
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    orderList[position].getOrderDate,
                                    style: cellTextStyle,
                                    textAlign: TextAlign.left,
                                  )),
                            )),
                        Container(
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                  alignment: Alignment.centerRight,
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    orderList[position].getTotalAmount,
                                    style: cellTextStyle,
                                    textAlign: TextAlign.right,
                                  )),
                            )),
                        Container(
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                  alignment: Alignment.centerRight,
                                  fit: BoxFit.scaleDown,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        orderList[position].customermodel !=
                                                null
                                            ? orderList[position]
                                                .customermodel
                                                .getName
                                            : 'N.A',
                                        style: cellTextStyle,
                                      ),
                                      Text(
                                        orderList[position].customermodel !=
                                                null
                                            ? orderList[position]
                                                .customermodel
                                                .getContact
                                            : 'N.A',
                                        style: TextStyle(fontSize: 14),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )),
                            )),
                        Container(
                            width: 100,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Text(
                                      orderList[position].getorderInvoice,
                                      style: cellTextStyle)),
                            ))),
                        Container(
                            width: 100,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Badge(
                                    badgeColor: (orderList[position].status ==
                                            'completed')
                                        ? Colors.green[900]
                                        : Colors.red[800],
                                    shape: BadgeShape.square,
                                    borderRadius: 20,
                                    toAnimate: false,
                                    badgeContent: Text(
                                        (orderList[position].status ==
                                                'completed')
                                            ? 'Completed'
                                            : 'Due ' +
                                                orderList[position].dueAmount,
                                        style: TextStyle(color: Colors.white)),
                                  )),
                            ))),
                        Container(
                            width: 200,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'hbashdashbdh  asjdasjdb j asjdjasdj ddsfsdf dfdsfsd',
                                style: cellTextStyle,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      )
    ],
  );
}

class OrdersDataSource extends DataTableSource {
  List<OrderModel> _desserts;
  init() {
    print(1111);
  }

  void _sort<T>(Comparable<T> getField(OrderModel d), bool ascending) {
    _desserts.sort((OrderModel a, OrderModel b) {
      if (!ascending) {
        final OrderModel c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _desserts.length && _desserts != null) return null;
    final OrderModel dessert = _desserts[index];
    return DataRow.byIndex(
      index: index,
      selected: dessert.selected,
      onSelectChanged: (bool value) {
        if (dessert.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          dessert.selected = value;
          notifyListeners();
        }
      },
      cells: <DataCell>[
        DataCell(Text('${dessert.getOrderDate}')),
        DataCell(Text('${dessert.getTotalAmount}')),
        DataCell(Text('${dessert.getStatus}')),
        DataCell(Text('${dessert.getCreatedDate}')),
      ],
    );
  }

  @override
  int get rowCount => _desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (OrderModel dessert in _desserts) dessert.selected = checked;
    _selectedCount = checked ? _desserts.length : 0;
    notifyListeners();
  }
}
