import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer' as developer;
import 'globalValues.dart';

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

    setState(() => this.controller = controller);
    controller.scannedDataStream.first.then((value) => {
          if (value.code != null)
            {
              value.code?.split("/").forEach((element) => foo.add(element)),
              print(foo),
              apiCall(foo),
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
    } catch (e) {
      print(e);
    }
  }
}
