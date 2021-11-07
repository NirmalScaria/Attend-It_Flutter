import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'detailsFormPage.dart';
class CheckLoginPage extends StatefulWidget {
  const CheckLoginPage({ Key? key }) : super(key: key);

  @override
  _CheckLoginPageState createState() => _CheckLoginPageState();
}

class _CheckLoginPageState extends State<CheckLoginPage> {
  @override
  void initState() {
    redirectIfLoggedin();
    // TODO: implement initState
    super.initState();
  }
  void redirectIfLoggedin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('student_name')!=null){
      Navigator.push(context,MaterialPageRoute(builder: (context) =>  HomePage()));
    }
    else{

      Navigator.push(context,MaterialPageRoute(builder: (context) =>  DetailsFormPage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeef6fa),
      body: Center(child: CircularProgressIndicator(),)
    );
  }
}