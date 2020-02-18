class CustomerModel {

  String name,contact;
  CustomerModel(this.name,this.contact);

  String get getName  => name;
  String get getContact =>contact;


  CustomerModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    contact = json['contact'];
  }
}