import 'package:niwcrm_jewel/models/ordersModel.dart';

class CustomerStats{

CustomerStats({this.customerPoints,this.customerTotalDue,this.customerTotalOrderValue,this.orders});

  String customerPoints;
  String customerTotalOrderValue,customerTotalDue;
  List<OrderModel> orders;

  String get getCustomerTotalPoints => customerPoints;
  String get getCustomerTotalOrderValue => customerTotalOrderValue;
  String get getCustomerTotalDue=> customerTotalDue;

  CustomerStats.fromJson(Map<String, dynamic> json) {
    var list = json['orders'] as List;
    print(list.runtimeType);
    List<OrderModel> orderslist = list.map((i) => OrderModel.fromJson(i)).toList();

    this.customerPoints = json['customerPoints'].toString();
    this.customerTotalDue = json['totalPendingvalue'];
    this.customerTotalOrderValue = json['totalOrderValue'];    
   
    this.orders = orderslist;  
    
  }
}