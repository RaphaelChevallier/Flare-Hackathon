import 'package:flutter/material.dart';
import 'package:good_neighbors/main.dart';
import 'components/rounded_buttons.dart';
import 'sign_in.dart';
import 'sign_up.dart';
import 'package:provider/provider.dart';
import 'authentication_service.dart';



class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WelcomeState();
  }
}

class _WelcomeState extends State<Welcome>  {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      // This size provide us total height and width of our screen
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "FLARE",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange, fontFamily: 'Montserrat', fontSize: 80.0),
            ),
            SizedBox(height: size.height * 0.05),
            //
            //
            //Place image here of flare logo
            //
            //
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AuthenticationWrapperMain();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AuthenticationWrapperSignUp();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}