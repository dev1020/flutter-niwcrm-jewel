import 'package:niwcrm_jewel/models/customerModel.dart';
class OrderModel {
  OrderModel(
      {this.orderId,
      this.orderDate,
      this.createdDate,
      this.totalAmount,
      this.dueAmount,
      this.status,
      this.selected,
      this.invoice,
      this.ordernote,
      this.customermodel,
    });
  OrderModel.orderlist(this.orderDate, this.createdDate, this.totalAmount,
      this.dueAmount, this.status, this.selected);
  int orderId, custId;

  CustomerModel customermodel;
  String orderDate,
      status,
      createdDate,
      invoice,
      ordernote;
  String totalAmount, dueAmount;
  bool selected = false;

  String get getOrderDate => orderDate;
  String get getCreatedDate => createdDate;
  String get getStatus => status;
  String get getTotalAmount => totalAmount;
  String get getDueAmount => dueAmount;
  int get getOrderId => orderId;
  String get getorderInvoice => invoice;
  String get getOrderNote => ordernote;

  OrderModel.fromJson(Map<String, dynamic> json) {
    createdDate = json['created_date'].toString();
    orderDate = json['order_date'].toString();
    status = json['status'].toString();
    totalAmount = json['total_amount'].toString();
    dueAmount = json['due_amount'].toString();
    ordernote = (json['order_note']!=null && json['order_note']!="")?json['order_note']:'N.A';
    invoice = (json['session_nos']!=null && json['session_nos']!="")?json['session_nos']:'N.A';
    if(json['cust']!=null){
      customermodel = CustomerModel.fromJson(json['cust']); 
    }
  }
}
