import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:niwcrm_jewel/pages/createOrder.dart';



import 'package:package_info/package_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:niwcrm_jewel/utils/customColors.dart';
import 'package:niwcrm_jewel/widgets/appBars.dart';
import 'package:niwcrm_jewel/widgets/custom_expansion_tile.dart' as customExpansionTile;


class DashBoardDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashBoardDrawerState();
  }
}

class DashBoardDrawerState extends State<DashBoardDrawer> {
  String _ispremium = 'Y';
  String _username, _useremail, _usercontact;
  String appName, packagename, version, buildnumber;

  @override
  initState() {
    super.initState();

    _getPackageInfo();
  }

  _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      this.appName = packageInfo.appName;
      this.buildnumber = packageInfo.buildNumber;
      this.version = packageInfo.version;
      this.packagename = packageInfo.packageName;
    });
  }

  Future<void> _signOut(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    var textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
      color: Colors.white,
    );

    const primaryLevelBackgroundColor = Colors.deepPurpleAccent;
    //const subListBackgroundColor = Color(0xB54CAF50);
    const iconColor = Color(0xFFffffff);
    var iconSize = ScreenUtil(allowFontScaling: true).setSp(40);

    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                PreferredSize(
                  preferredSize: Size.fromHeight(85.0),
                  child: GradientAppBar(
                    automaticallyImplyLeading: false,
                    flexibleSpace: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomPaint(
                          painter: CircleOne(),
                        ),
                        CustomPaint(
                          painter: CircleTwo(),
                        ),
                      ],
                    ),
                    title: Image(
                      image: new AssetImage("assets/images/logo.png"),
                      fit: BoxFit.cover,
                      // color:Colors.black87,
                      // colorBlendMode: BlendMode.darken,
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 30.0,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                    elevation: 3,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [CustomColors.TextWhite, Colors.deepPurpleAccent],
                    ),
                  ),
                ),
                Divider(
                  height: 1.0,
                ),
                Ink(
                  color: primaryLevelBackgroundColor,
                  child: ListTile(
                      title: Text('Home', style: textStyle),
                      onTap: () {},
                      leading: Icon(
                        Icons.home,
                        color: iconColor,
                        size: iconSize,
                      ),
                      trailing: Icon(FontAwesomeIcons.solidArrowAltCircleRight,
                          color: Color(0xFFffffff), size: 18.0)),
                ),
                Divider(
                  height: 1.0,
                ),
                Ink(
                  color: primaryLevelBackgroundColor,
                  child: ListTile(
                      title: Text('Company Customers', style: textStyle),
                      onTap: () {
                        var newRouteName = '/companyCustomers';
                        bool isNewRouteSameAsCurrent = false;

                        Navigator.popUntil(context, (route) {
                          Navigator.pop(context);
                          if (route.settings.name == newRouteName) {
                            isNewRouteSameAsCurrent = true;
                          }
                          return true;
                        });

                        if (!isNewRouteSameAsCurrent) {
                          Navigator.pushNamed(context, newRouteName);
                        }
                      },
                      leading: Icon(
                        Icons.supervised_user_circle,
                        color: iconColor,
                        size: iconSize,
                      ),
                      trailing: Icon(FontAwesomeIcons.solidArrowAltCircleRight,
                          color: Color(0xFFffffff), size: 18.0)),
                ),
                customExpansionTile.ExpansionTile(
                  iconColor: iconColor,
                  title: Text('Sales Summary', style: textStyle),
                  leading: Icon(
                    Icons.content_copy,
                    color: iconColor,
                    size: iconSize,
                  ),
                  headerBackgroundColor: primaryLevelBackgroundColor,
                  children: <Widget>[
                    drawerListTile('New Sale', '/newSale'),
                    Divider(
                      height: 1.0,
                    ),
                    drawerListTile('Today\'s Opened Sale', CreateOrder()),
                    Divider(
                      height: 1.0,
                    ),
                    drawerListTile('Appoval Pending Sale', CreateOrder()),
                    Divider(
                      height: 1.0,
                    ),
                    drawerListTile('All Sales', '/allSales'),
                  ],
                ),
                customExpansionTile.ExpansionTile(
                  iconColor: iconColor,
                  title: Text('Point Summary', style: textStyle),
                  leading: Icon(
                    Icons.card_giftcard,
                    color: iconColor,
                    size: iconSize,
                  ),
                  headerBackgroundColor: primaryLevelBackgroundColor,
                  children: <Widget>[
                    drawerListTile('Points Details', CreateOrder()),
                    Divider(
                      height: 1.0,
                    ),
                    drawerListTile('Gift Points', CreateOrder()),
                  ],
                ),
                customExpansionTile.ExpansionTile(
                  title: Text('Promotions', style: textStyle),
                  iconColor: iconColor,
                  leading: Icon(
                    FontAwesomeIcons.bullhorn,
                    color: iconColor,
                    size: 20,
                  ),
                  headerBackgroundColor: primaryLevelBackgroundColor,
                  children: <Widget>[
                    drawerListTile('Manage SMS Template', CreateOrder()),
                    Divider(
                      height: 1.0,
                    ),
                    drawerListTile('Promote Via SMS', CreateOrder()),
                  ],
                ),
                Divider(
                  height: 1.0,
                ),
                Ink(
                  color: primaryLevelBackgroundColor,
                  child: ListTile(
                      title: Text('Settings', style: textStyle),
                      onTap: () {},
                      leading: Icon(
                        Icons.settings,
                        color: iconColor,
                        size: iconSize,
                      ),
                      trailing: Icon(FontAwesomeIcons.solidArrowAltCircleRight,
                          color: Color(0xFFffffff), size: 18.0)),
                ),
                Divider(
                  height: 1.0,
                ),
                Ink(
                  color: primaryLevelBackgroundColor,
                  child: ListTile(
                    title: Text('LOGOUT', style: textStyle),
                    onTap: () {
                      return showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text(
                                  'Sure you want to logout from this app ?',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xFFa0a0a0))),
                              // content: const Text('Sure To delete This Item ?'),
                              actions: <Widget>[
                                FlatButton(
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  disabledColor: Colors.grey,
                                  disabledTextColor: Colors.black,
                                  padding: EdgeInsets.all(2.0),
                                  splashColor: Colors.redAccent,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.power_settings_new),
                                      Text(" Ok"),
                                    ],
                                  ),
                                  onPressed: () {
                                    _signOut(context);
                                  },
                                )
                              ]);
                        },
                      );
                    },
                    leading: Icon(
                      Icons.power_settings_new,
                      color: iconColor,
                      size: iconSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              // This align moves the children to the bottom
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  // This container holds all the children that will be aligned
                  // on the bottom and should not scroll with the above ListView
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage("assets/salt.png"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Text(
                              ' A Social Initiative by SALTLAKE.IN Web Services LLP.',
                              style: TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true)
                                      .setSp(25),
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Text(' VERSION - $version.$buildnumber'),
                          )
                        ],
                      ))))
        ],
      ),
    );
  }

  ListTile drawerListTile(String text, routenamed) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text),
        ],
      ),
      onTap: () {
        var newRouteName = routenamed;
        bool isNewRouteSameAsCurrent = false;

        Navigator.popUntil(context, (route) {
          Navigator.pop(context);
          if (route.settings.name == newRouteName) {
            isNewRouteSameAsCurrent = true;
          }
          return true;
        });

        if (!isNewRouteSameAsCurrent) {
          Navigator.pushNamed(context, newRouteName);          
        }
      },
    );
  }

  Ink buildInk(String listname) {
    return Ink(
      child: ListTile(
        title: Text(
          listname,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16.0,
          ),
        ),
        onTap: () => {},
        //contentPadding: EdgeInsets.all(0.0),
        trailing: Icon(FontAwesomeIcons.solidArrowAltCircleRight,
            color: Color(0xFFffffff), size: 18.0),
      ),
      padding: EdgeInsets.only(left: 30.0),
    );
  }

  Image isPremiumIcon() {
    if (this._ispremium == 'Y') {
      return Image(
        image: AssetImage("assets/premium.png"),
      );
    } else {
      return null;
    }
  }
}
