import 'dart:ui';
import 'package:attendit/screens/finger_print_page.dart';

import 'globalValues.dart';
import 'package:attendit/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DetailsFormPage extends StatefulWidget {
  const DetailsFormPage({Key? key}) : super(key: key);

  @override
  _DetailsFormPageState createState() => _DetailsFormPageState();
}

class _DetailsFormPageState extends State<DetailsFormPage> {
  void initState() {
    // TODO: implement initState
    redirectIfLoggedin();
    super.initState();
  }
  void redirectIfLoggedin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('student_name')!=null){
      Navigator.push(context,MaterialPageRoute(builder: (context) =>  fingerPrintPage()));
    }
  }
  var errormsg="";
  var name=TextEditingController();
  var rollno=TextEditingController();
  @override
  
  void register() async{
    if(name.text.length<4){
      setState(() {
        errormsg="Name must be at least 4 letters long";
      });
    }
    else if(rollno.text==""){
      setState(() {
        errormsg="Roll no cannot be empty";
      });
    }
    else{
      setState(()  {
        errormsg="";
        
      });
      SharedPreferences prefs=await SharedPreferences.getInstance();
        await prefs.setString('student_name', name.text);
        await prefs.setString('roll_no',rollno.text);
        student_Name=name.text;
        roll_no=rollno.text;
      Navigator.push(context,MaterialPageRoute(builder: (context) =>  fingerPrintPage())); 
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeef6fa),
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Color(0xffe0e0e0), shape: BoxShape.circle),
              height: MediaQuery.of(context).size.width * 0.9,
              width: MediaQuery.of(context).size.width * 0.9,
              transform: Matrix4.translationValues(
                  MediaQuery.of(context).size.width * 0.4,
                  MediaQuery.of(context).size.width * -0.1,
                  0)),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff002e6e), width: 27),
                  shape: BoxShape.circle),
              height: MediaQuery.of(context).size.width * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
              transform: Matrix4.translationValues(
                  MediaQuery.of(context).size.width * -0.2,
                  MediaQuery.of(context).size.width * 0.9,
                  0)),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff00b9f1), width: 27),
                  shape: BoxShape.circle),
              height: MediaQuery.of(context).size.width * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              transform: Matrix4.translationValues(
                  MediaQuery.of(context).size.width * 0.7,
                  MediaQuery.of(context).size.width * 01.0,
                  0)),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2, left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Authentication\nsuccessful",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                      color: Color(0xff002e6e),
                      fontSize: 39,
                      fontWeight: FontWeight.w800,
                    )),
                  ),
                  SizedBox(height:10),
                  Text("Please register to continue.",style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                      color: Color(0xff00b9f1),
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    )),)
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:10),
                    Text("Register",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(fontSize: 21),
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 15),
                    errormsg!="" ? Text(errormsg, style: GoogleFonts.roboto(textStyle: TextStyle(color:Colors.red)),) : SizedBox(),
                    SizedBox(height:15),
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        label: Text("Name"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13)),
                      ),
                    ),
                    SizedBox(height: 20),
                    
                    TextFormField(
                      controller: rollno,
                      decoration: InputDecoration(
                        label: Text("Roll no"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13)),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff002e6e)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                ))),
                            onPressed: () {
                              register();
                            },
                            child: Text("Register",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ))))),
                    SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "By registering you agre with our ",
                            style: GoogleFonts.roboto(textStyle: TextStyle( color: Color(0xff939393), fontSize: 14)),
                            children: [
                          TextSpan(text: "Terms and Conditions", style: TextStyle(color: Color(0xff00B9f1))),
                          TextSpan(text:" and "),
                          TextSpan(text: "Privacy Policy",  style: TextStyle(color: Color(0xff00B9f1)))
                        ])),
                    SizedBox(height: 10)
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(blurRadius: 20, color: Color(0xcccccccc))
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
}
