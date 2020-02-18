class DashBoardModel{
  DashBoardModel(this.allCustomers,this.approvalPending,this.cancelledOrder,this.latestOrder,this.latestOrderId,this.newCustomers,this.saleThisMonth,this.todaysSale);
  int todaysSale,latestOrder,saleThisMonth;

  int cancelledOrder,allCustomers,newCustomers,approvalPending,latestOrderId;
  //ALL GETTERS

  int get getTodaysSale      => todaysSale;
  int get getLatestOrder     => latestOrder;
  int get getSaleThisMonth   => saleThisMonth;
  int get getcancelledOrder  => cancelledOrder;
  int get getAllCustomers    => allCustomers;
  int get getNewCustomers    => newCustomers;
  int get getApprovalPending => approvalPending;
  int get getLatestOrderId   => latestOrderId;

  DashBoardModel.fromJson(Map<String,dynamic> json){
    todaysSale = json['ordertotalToday'];
    latestOrder = json['latestOrder'];
    saleThisMonth = json['ordertotalThisMonth'];
    cancelledOrder = json['cancelledOrders'];
    allCustomers = json['allCustomers'];
    newCustomers = json['customersThisMonth'];
    approvalPending = json['approvalPending'];
    latestOrderId = json['latestOrderId'];
  }

}