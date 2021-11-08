import 'package:attendit/screens/finger_print_page.dart';
import 'package:attendit/screens/homepage.dart';
import 'package:attendit/screens/sign_in_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CheckLoginPage.dart';
import 'package:google_fonts/google_fonts.dart';

class signInPage extends StatefulWidget {
  signInPage({Key? key}) : super(key: key);

  @override
  _signInPageState createState() => _signInPageState();
}

class _signInPageState extends State<signInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('some error occured'),
              );
            } else if (snapshot.hasData) {
              return const CheckLoginPage();
            } else {
              return Scaffold(
                body: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('some error occured'),
                        );
                      } else if (snapshot.hasData) {
                        return const CheckLoginPage();
                      } else {
                        return Scaffold(
                          backgroundColor: Color(0xffeef6fa),
                          body: Stack(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffe0e0e0),
                                      shape: BoxShape.circle),
                                  height:
                                      MediaQuery.of(context).size.width * 0.9,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  transform: Matrix4.translationValues(
                                      MediaQuery.of(context).size.width * 0.4,
                                      MediaQuery.of(context).size.width * -0.1,
                                      0)),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xff002e6e), width: 27),
                                      shape: BoxShape.circle),
                                  height:
                                      MediaQuery.of(context).size.width * 0.7,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  transform: Matrix4.translationValues(
                                      MediaQuery.of(context).size.width * -0.2,
                                      MediaQuery.of(context).size.width * 0.9,
                                      0)),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xff00b9f1), width: 27),
                                      shape: BoxShape.circle),
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  transform: Matrix4.translationValues(
                                      MediaQuery.of(context).size.width * 0.7,
                                      MediaQuery.of(context).size.width * 01.0,
                                      0)),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.2,
                                      left: 50),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hello,\nWelcome!",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                          color: Color(0xff002e6e),
                                          fontSize: 39,
                                          fontWeight: FontWeight.w800,
                                        )),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Please sign in with Google.",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                          color: Color(0xff00b9f1),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        )),
                                      )
                                    ],
                                  )),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: DecoratedBox(
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: EdgeInsets.all(30),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        Text("New user?",
                                            style: GoogleFonts.roboto(
                                                textStyle:
                                                    TextStyle(fontSize: 18),
                                                fontWeight: FontWeight.w400)),
                                        SizedBox(height: 10),
                                        SizedBox(
                                            width: double.infinity,
                                            height: 60,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    side: BorderSide(
                                                        width: 1.0,
                                                        color:
                                                            Color(0xffbbbbbb)),
                                                    primary: Colors.white,
                                                    shape:
                                                        new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    13))),
                                                onPressed: () {
                                                  final provider = Provider.of<
                                                          GoogleSignInProvider>(
                                                      context,
                                                      listen: false);
                                                  provider.googleLogin();
                                                },
                                                child: Row(
                                                  children: [
                                                    Image(
                                                        image: AssetImage(
                                                            'lib/assets/google.png'),
                                                        height: 23),
                                                    SizedBox(width: 10),
                                                    Text("Sign up with Google",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                textStyle:
                                                                    TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ))),
                                                  ],
                                                ))),
                                        SizedBox(height: 20),
                                        Text("Already have an account?",
                                            style: GoogleFonts.roboto(
                                                textStyle:
                                                    TextStyle(fontSize: 18),
                                                fontWeight: FontWeight.w400)),
                                        SizedBox(height: 10),
                                        SizedBox(
                                            width: double.infinity,
                                            height: 60,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    side: BorderSide(
                                                        width: 1.0,
                                                        color:
                                                            Color(0xffbbbbbb)),
                                                    primary: Colors.white,
                                                    shape:
                                                        new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    13))),
                                                onPressed: () {
                                                  final provider = Provider.of<
                                                          GoogleSignInProvider>(
                                                      context,
                                                      listen: false);
                                                  provider.googleLogin();
                                                },
                                                child: Row(
                                                  children: [
                                                    Image(
                                                        image: AssetImage(
                                                            'lib/assets/google.png'),
                                                        height: 23),
                                                    SizedBox(width: 10),
                                                    Text("Use Google to log in",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                textStyle:
                                                                    TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ))),
                                                  ],
                                                ))),
                                        SizedBox(height: 10),
                                        RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                text:
                                                    "By registering you agre with our ",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xff939393),
                                                        fontSize: 14)),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "Terms and Conditions",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff00B9f1))),
                                                  TextSpan(text: " and "),
                                                  TextSpan(
                                                      text: "Privacy Policy",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff00B9f1)))
                                                ])),
                                        SizedBox(height: 10)
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 20,
                                            color: Color(0xcccccccc))
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                ),
                              )
                            ],
                          ),
                        );
              
                      }
                    }),
              );
              
            }
          }),
    );
  }
}
