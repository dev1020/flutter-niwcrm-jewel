
import 'package:niwcrm_jewel/models/customerStatsModel.dart';

class CompanyCustomersModel {
  CompanyCustomersModel(this._customerId,this._customerName, this._customerContact,{this.customerStats});
  String _customerName;
  int _customerId;
  String _customerContact;
  
  String _createdDate;
  CustomerStats customerStats;

  bool selected = false;
  String get getCustomerName => _customerName;
  int get getCustomerId => _customerId;
  String get getCustomerContact => _customerContact;
  String get getCustomerCreatedDate => _createdDate;
  

  set companycustomerId(int customerId) {
    this._customerId = customerId;
  }
  set companycustomerCreatedDate(String createdDate) {
    this._createdDate = createdDate;
  }
  set companycustomerName(String customerName) {
    this._customerName = customerName;
  }
  set companycustomerContact(String customerContact) {
    this._customerContact = customerContact;
  }

  CompanyCustomersModel.fromJson(Map<String, dynamic> json) {
    //var list = json['orders'] as List;
    //print(list.runtimeType);
   // List<OrderModel> orderslist = list.map((i) => OrderModel.fromJson(i)).toList();

    this._customerId = json['cust_id'];
    this._customerName = json['cust']['name'];
    this._customerContact = json['customer_number'];    
    this._createdDate = json['created_date'];
   // this.orders = orderslist;    
  }
}


