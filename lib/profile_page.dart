import 'dart:convert';

import 'package:clickern/main.dart';
import 'package:clickern/model/common.dart';
import 'package:clickern/model/user_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserData? userData;
  DeviceInfo? deviceInfo;
  List<Widget> data = <Widget>[];

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    () async {
      deviceInfo = await CommonLibFunction.getDeviceDetails();
      //print(deviceInfo.toString());
      http.post(Uri.parse(API_URL + '/getUserDetails'),
          body: {'sessionId': sessionId}).then(
        (value) {
          userData = UserData.fromMap(jsonDecode(value.body));
          if (kDebugMode) print(userData);
          data.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                const Expanded(
                  flex: 3,
                  child: Text('User Name'),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    userData!.username,
                  ),
                ),
              ],
            ),
          );

          data.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                const Expanded(
                  flex: 3,
                  child: Text('Name'),
                ),
                Expanded(
                  flex: 4,
                  child: Text(userData!.firstName + " " + userData!.lastName),
                ),
              ],
            ),
          );

          data.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                const Expanded(
                  flex: 3,
                  child: Text('Email'),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    userData!.email,
                  ),
                ),
              ],
            ),
          );

          data.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                const Expanded(
                  flex: 3,
                  child: Text('Mobile Number'),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    userData!.mobileNumber,
                  ),
                ),
              ],
            ),
          );

          setState(
            () {},
          );
        },
      );
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: data,
      ),
    );
  }
}
