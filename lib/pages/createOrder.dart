import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:niwcrm_jewel/utils/customColors.dart';

class CreateOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateOrderState();
  }
}

class CreateOrderState extends State<CreateOrder> {
  String orderDate;
  TextEditingController orderdatew = TextEditingController();
  var myFormat = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    var labelStyle = TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, color: Colors.green[900]);
    var iconcolor = Colors.black;
    const outlineInputBorder = const OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: const BorderSide(color: CustomColors.GreenDark, width: 0.0),
                    );
        return Container(
          decoration: BoxDecoration(),
          padding: EdgeInsets.all(5.0),
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: 0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Order Date', style: labelStyle),
              ),
              ListTile(
                title: InkWell(
                  onTap: () {
                    // Call Function that has showDatePicker()
                    _selectDate();
                  },
                  child: IgnorePointer(
                    child: new TextFormField(
                      controller: orderdatew,
                      decoration: InputDecoration(
                        enabledBorder: outlineInputBorder,
                        icon: Icon(
                          Icons.calendar_today,
                          color: iconcolor,
                        ),
                        hintText: 'Order Date:-',
                      ),
                      maxLength: 10,
                      // validator: validateDob,
                      onSaved: (String val) {},
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Customer Contact Without +91', style: labelStyle),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: outlineInputBorder,
                    icon: Icon(
                      Icons.phone,
                      color: iconcolor,
                    ),
                    hintText: 'Contact',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Customer Name', style: labelStyle),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: outlineInputBorder,
                    icon: Icon(
                      Icons.person,
                      color: iconcolor,
                    ),
                    hintText: 'Customer Name',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Invoice Number', style: labelStyle),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: outlineInputBorder,
                    icon: Icon(
                      FontAwesomeIcons.fileInvoice,
                      color: iconcolor,
                    ),
                    hintText: 'Invoice',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Total Amount', style: labelStyle),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                   enabledBorder: outlineInputBorder,
                    icon: Icon(
                      FontAwesomeIcons.rupeeSign,
                      color: iconcolor,
                    ),
                    hintText: 'Amount',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Weight(gm)', style: labelStyle),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: outlineInputBorder,
                    icon: Icon(
                      FontAwesomeIcons.weight,
                      color: iconcolor,
                    ),
                    hintText: 'Weight',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Note', style: labelStyle),
              ),
              ListTile(
                title: TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    enabledBorder: outlineInputBorder,
                
                icon: Icon(
                  FontAwesomeIcons.stickyNote,
                  color: iconcolor,
                ),
                hintText: 'Note',
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            padding: EdgeInsets.all(20),
            child: RaisedButton(
              onPressed: () {
                // HERO-ANIMATION: https://github.com/flutter/flutter/issues/28041
                // Navigator.of(context).pushReplacement(
                //   PageRouteBuilder(
                //     transitionDuration: Duration(seconds: 1),
                //     pageBuilder: (_, __, ___) => Empty(),
                //   ),
                // );
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      CustomColors.GreenLight,
                      CustomColors.GreenDark,
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.GreenShadow,
                      blurRadius: 15.0,
                      spreadRadius: 7.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Center(
                  child: const Text(
                    'Create Order',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (picked != null)
      setState(() => orderdatew.text = myFormat.format(picked));
  }
}
