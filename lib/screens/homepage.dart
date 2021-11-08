import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer' as developer;
import 'globalValues.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference qrLink = FirebaseFirestore.instance.collection("courses");
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  //Remove this
  @override
  void initState() {
    developer.log('Student name : $student_Name');
    developer.log("Roll no : $roll_no");
  }
  //till here

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        buildQrView(context),
      ],
    ));
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQrViewCreated,
        overlay: QrScannerOverlayShape(
          borderLength: 30,
          borderWidth: 10,
          borderRadius: 10,
          borderColor: Colors.blue,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );

  void onQrViewCreated(QRViewController controller) {
    var foo = List<String>.empty(growable: true);
    var presenttime;
    var qrtime;
    var timedifference;
    setState(() => this.controller = controller);
    controller.scannedDataStream.first.then((value) => {
          if (value.code != null)
            {
              value.code?.split("/").forEach((element) => foo.add(element)),
              print(foo),
              presenttime = DateTime.now(),
              foo[3] = foo[3].replaceAll('-', '/'),
              print(foo[3] + ' ' + foo[4]),
              qrtime = DateTime.parse(
                  DateFormat('yyyy-MM-dd').format(presenttime) +
                      ' ' +
                      '23:59:59'),
              //qrtime = DateTime.parse('2021-10-08' + ' ' + foo[4]),
              presenttime = DateTime.now(),
              timedifference = presenttime.difference(qrtime).inSeconds,
              if (timedifference < 30)
                {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Confirm submit?'),
                      content: Text(
                          'You are about to submit attendance for ${foo[2]} on ${foo[3]}'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'OK');
                            apiCall(foo);
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                }
              else
                {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Time limit exceeded'),
                      content: Text(
                          'The time limite for submitting attendance has exceeded. Please contact your teacher.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                },
            },
        });
  }

  void apiCall(List<String> foo) {
    try {
      qrLink
          .doc(foo[0])
          .collection("subject")
          .doc(foo[1])
          .collection(foo[2] + foo[3])
          .add({"NAME": student_Name, "ROLL NO": roll_no});
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Successful'),
          content: Text(
              'You have successfully marked the attendace for this class.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
