import 'package:attendit/screens/finger_print_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'detailsFormPage.dart';
import 'globalValues.dart';
class CheckLoginPage extends StatefulWidget {
  const CheckLoginPage({ Key? key }) : super(key: key);

  @override
  _CheckLoginPageState createState() => _CheckLoginPageState();
}

class _CheckLoginPageState extends State<CheckLoginPage> {
  @override
  void initState() {
    redirectIfLoggedin();
    super.initState();
  }
  void redirectIfLoggedin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('student_name')!=null){
      student_Name = prefs.getString('student_name')!;
      roll_no = prefs.getString('roll_no')!;
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  fingerPrintPage()));
    }
    else{
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  DetailsFormPage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffeef6fa),
      body: Center(child: CircularProgressIndicator(),)
    );
  }
}