import 'package:attendit/screens/finger_print_page.dart';
import 'package:attendit/screens/homepage.dart';
import 'package:attendit/screens/sign_in_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CheckLoginPage.dart';
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
              return const  CheckLoginPage();
            } else {
              return Center(
                child: ElevatedButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                    },
                    child: const Text("sign in to google")),
              );
            }
          }),
    );
  }
}
