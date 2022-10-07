import 'dart:convert';

import 'package:clickern/main.dart';
import 'package:clickern/model/common.dart';
import 'package:clickern/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  UserData? userData;
  DeviceInfo? deviceInfo;
  List<Widget> data = <Widget>[];
  int todayClicks = 0;
  double todayEarn = 0;

  int totalClicks = 0;
  double totalEarn = 0;

  double paymentRecieved = 0;
  double paymentRemaining = 0;

  double perClickCost = 0;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    //print(deviceInfo.toString());
    http.post(Uri.parse(API_URL + '/fetchPaymentDetails'),
        body: {'sessionId': sessionId}).then(
      (value) {
        var data = jsonDecode(value.body);
        if (data['status'] == 'OK') {
          setState(() {
            todayClicks = int.parse(data['todayCount'].toString());
            totalClicks = int.parse(data['totalCount'].toString());
            perClickCost = double.parse(data['perClickCost'].toString());

            todayEarn = (todayClicks * perClickCost * 1000).round() / 1000.0;
            totalEarn = (totalClicks * perClickCost * 1000).round() / 1000.0;

            paymentRecieved = double.parse(data['totalPaid'].toString());
            paymentRemaining =
                ((totalEarn - paymentRecieved) * 1000).round() / 1000.0;
          });
        } else {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(2, 2, 2, 1),
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 70,
              maxWidth: double.infinity,
              maxHeight: 70,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.grey.shade200,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const Positioned(
                  left: 5,
                  top: 5,
                  child: Text('Today'),
                ),
                Positioned(
                  left: 5,
                  top: 40,
                  child: Text('Clicks: ' + todayClicks.toString()),
                ),
                Positioned(
                  right: 5,
                  top: 40,
                  child: Text('Earn: \u{20B9} ' + todayEarn.toString()),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 2, 2, 1),
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 70,
              maxWidth: double.infinity,
              maxHeight: 70,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.grey.shade200,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const Positioned(
                  left: 5,
                  top: 5,
                  child: Text('Total'),
                ),
                Positioned(
                  left: 5,
                  top: 40,
                  child: Text('Clicks: ' + totalClicks.toString()),
                ),
                Positioned(
                  right: 5,
                  top: 40,
                  child: Text('Earn: \u{20B9} ' + totalEarn.toString()),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 2, 2, 1),
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 70,
              maxWidth: double.infinity,
              maxHeight: 70,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.grey.shade200,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const Positioned(
                  left: 5,
                  top: 5,
                  child: Text('Payment'),
                ),
                Positioned(
                  left: 5,
                  top: 40,
                  child: Text(
                    'Recieved: \u{20B9} ' + paymentRecieved.toString(),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 40,
                  child: Text(
                    'Remaining: \u{20B9} ' + paymentRemaining.toString(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
