import 'package:clickern/model/common.dart';
import 'package:clickern/model/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserData? userData;
  DeviceInfo? deviceInfo;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    () async {
      deviceInfo = await CommonLibFunction.getDeviceDetails();
      //print(deviceInfo.toString());
      setState(() {});
    }();
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(deviceInfo?.deviceName ?? ''),
              const Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
              Text(userData?.firstName ?? 'NA'),
            ],
          ),
          Row(
            children: [
              const Text('Last Name: '),
              Text(userData?.firstName ?? 'NA'),
            ],
          )
        ],
      ),
    );
  }
}
