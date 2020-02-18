import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'auth_utils.dart';

class NetworkUtils {
	static final String host = productionHost;
	static final String productionHost = 'https://niwcrm.com/jeweltest/api/web/v1/';
 
  
	static dynamic authenticateUser(String contact, String password) async {
		var uri = host + AuthUtils.endPoint;
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = '{"username": "$contact", "password": "$password"}'; 
   // print(contact);
   // print(password);
   // print(jsonBody);
		try {
			final response = await http.post(
				uri,
        headers: headers,
				body: jsonBody
			);

			final Map<String, dynamic > responseJson = json.decode(response.body);
      print(responseJson);
			return responseJson;

		} catch (exception) {
			print(exception);
			if(exception.toString().contains('SocketException')) {
				return 'NetworkError';
			} else {
				return null;
			}
		}
	}

	static logoutUser(BuildContext context, SharedPreferences prefs) {
		prefs.setString(AuthUtils.authTokenKey, null);
		prefs.setInt(AuthUtils.userIdKey, null);
		prefs.setString(AuthUtils.sosPremiumKey, null);
    prefs.setString(AuthUtils.sosRegisterKey, null);
		return null;
	}

	static showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message) {
		scaffoldKey.currentState.showSnackBar(
			new SnackBar(
        behavior: SnackBarBehavior.floating,
				content: Container(alignment: Alignment.bottomCenter, height: 35.0, child:Center(child: new Text(message ?? 'You are offline'))),
			)
		);
	}

	static fetch(var authToken, var endPoint) async {
		var uri = host + endPoint+'access-token=$authToken';
    print(uri);
		try {
			final response = await http.get(uri);

			//final responseJson = json.decode(response.body);
			//final responseJsonhead = (response.headers['x-pagination-page-count']);
      
			return response;

		} catch (exception) {
			print(exception);
			if(exception.toString().contains('SocketException')) {
				return 'NetworkError';
			} else {
				return null;
			}
		}
	}
}