import 'package:flutter/material.dart';
import 'package:niwcrm_jewel/pages/dashboardpage.dart';


class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RootPageState();
  }
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class RootPageState extends State<RootPage> {
  
  bool isLoading = true;
  void initState() {
    //_fetchAuthToken();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  
  @override
  Widget build(BuildContext context) {
    
        return DashBoard();
      
  }

  
}
