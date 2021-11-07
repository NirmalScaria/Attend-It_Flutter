import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fingerprint_api.dart';
import 'homepage.dart';
import 'dart:developer' as developer;

class fingerPrintPage extends StatefulWidget {
  const fingerPrintPage({Key? key}) : super(key: key);

  @override
  _fingerPrintPageState createState() => _fingerPrintPageState();
}

class _fingerPrintPageState extends State<fingerPrintPage> {
  var errorMsg = "";
  @override
  initState() {
    LocalAuthApi.authenticate().then((isAuthenticated) {
      if (isAuthenticated) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        setState(() {
          errorMsg = "Fingerprint is required to continue!";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () async {
                  developer.log("YI");
                  final isAuthenticated = await LocalAuthApi.authenticate();
                  if (isAuthenticated) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  }
                },
                child: Image(
                    image: errorMsg == ""
                        ? const AssetImage("lib/assets/fingerprint_waiting.png")
                        : const AssetImage("lib/assets/fingerprint_fail.png"))),
            errorMsg == ""
                ? const SizedBox()
                : Text(errorMsg,
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold))),
            const SizedBox(height: 30),
            errorMsg == ""
                ? const SizedBox()
                : TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(14),
                        backgroundColor: const Color(0xff00b9f1),
                        primary: Colors.white,
                        onSurface: Colors.red),
                    onPressed: () {
                      setState(() {
                        errorMsg = "";
                      });
                      LocalAuthApi.authenticate().then((isAuthenticated) {
                        if (isAuthenticated) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        } else {
                          setState(() {
                            errorMsg = "Fingerprint is required to continue!";
                          });
                        }
                      });
                    },
                    child: const Text("Try again")),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
