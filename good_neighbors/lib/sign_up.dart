import 'package:flutter/material.dart';
import 'components/rounded_buttons.dart';
import 'authentication_service.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 90.0, 0.0, 0.0),
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 80.0, fontWeight: FontWeight.bold)
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(45.0, 155.0, 0.0, 0.0),
                  child: Text(
                    'To',
                    style: TextStyle(
                      fontSize: 80.0, fontWeight: FontWeight.bold)
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(75.0, 220.0, 0.0, 0.0),
                  child: Text(
                    'Flare.',
                    style: TextStyle(
                      fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.deepOrange)
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0, right:20.0),
              child: Column(
                children: <Widget>[
                  RoundedInputField(
                    controller: emailController,
                    hintText: "Your Email",
                    onChanged: (value) {},
                  ),
                  RoundedPasswordField(
                    controller: passwordController,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 20.0),
                  RoundedButton(
                    text: "SIGN UP",
                    press: () {
                      context.read<AuthenticationService>().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      );
                    },
                  ),
                  RoundedGoogleButton(
                    text: "Sign Up With Google",
                    press: () {},
                  ),
                ]
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontFamily: 'Montserrat'
                  ),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AuthenticationWrapperMain();
                      },
                    ),
                  );
                  },
                  child: Text('Sign In',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline
                  ),
                  )),
              ],
            ),
            ]),
        ],
      ),
    );
  }
}