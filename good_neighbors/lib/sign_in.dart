import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication_service.dart';
import 'components/rounded_buttons.dart';
import 'main.dart';

class Signin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SigninState();
  }
}

class _SigninState extends State<Signin> {
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
                    'Hello',
                    style: TextStyle(
                      fontSize: 80.0, fontWeight: FontWeight.bold)
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(45.0, 165.0, 0.0, 0.0),
                  child: Text(
                    'There',
                    style: TextStyle(
                      fontSize: 80.0, fontWeight: FontWeight.bold)
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(250.0, 165.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                      fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.deepOrange)
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top:40.0, left: 20.0, right:20.0),
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
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(left: 20.0),
                  child: InkWell(
                    child: Text('Forgot Password', style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                RoundedButton(
                  text: "LOGIN",
                  press: () {
                    context.read<AuthenticationService>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  },
                ),
                // Container(
                //   height: 42.0,
                //   child: Material(
                //     borderRadius: BorderRadius.circular(20.0),
                //     shadowColor: Colors.deepOrangeAccent,
                //     color: Colors.deepOrange,
                //     child: GestureDetector(
                //       onTap: () {},
                //       child: Center(
                //         child: Text(
                //           'LOGIN',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: 'Montserrat'
                //           ),
                //         ),
                //       ),
                //     )
                //   )
                // ),
                RoundedGoogleButton(
                  text: "Sign In With Google",
                  press: () {},
                ),
                // Container(
                //   height: 42.0,
                //   color: Colors.transparent,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Colors.black,
                //         style: BorderStyle.solid,
                //         width: 1.0
                //       ),
                //       color: Colors.transparent,
                //       borderRadius: BorderRadius.circular(20.0)
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: <Widget>[
                //         Center(
                //           child: Image(image: AssetImage('assets/images/google_logo.png'), color: null, height: 30.0),
                //         ),
                //         SizedBox(width: 10.0),
                //         Center(
                //           child: Text('Log in with Google',
                //            style: TextStyle(
                //              fontWeight: FontWeight.bold,
                //              fontFamily: 'Montserrat'
                //            )),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ]
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'New to Flare?',
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
                      return AuthenticationWrapperSignUp();
                    },
                  ),
                );
                },
                child: Text('Register Now',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline
                ),
                )),
            ],
          ),
        ],
      ),
    );
  }
}