import 'package:flutter/material.dart';

import 'package:niwcrm_jewel/widgets/bottomSheet.dart';
import 'package:niwcrm_jewel/utils/customColors.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Container customFab(context,data) {
  Modal modal = Modal(data);

  return Container(
    height: 70.0,
    width: 70.0,
    decoration: new BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          CustomColors.PurpleLight,
          CustomColors.PurpleDark,
        ],
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(50.0),
      ),
      boxShadow: [
        BoxShadow(
          color: CustomColors.PurpleShadow,
          blurRadius: 5.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    margin: EdgeInsets.only(bottom: 1.0),
    child: FittedBox(
      child: FloatingActionButton(
        elevation: 12.0,
        backgroundColor: Colors.transparent,
        splashColor: Colors.green,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.white,
                size: 35.0,
              ),
              Text(
                    'Orders',
                    style: TextStyle(fontSize: 10.0, color: Colors.white),
                  ),
            ],
          ),
        ),
        onPressed: () {
          modal.mainBottomSheet(context);
        },
      ),
    ),
  );
}
