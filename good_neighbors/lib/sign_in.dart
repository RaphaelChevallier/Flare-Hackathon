import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SigninState();
  }
}

class _SigninState extends State<Signin> {

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
                TextField(
                  decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                      fontFamily: 'MontSerrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                      fontFamily: 'MontSerrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                    child: Text('Forgot Password', style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                Container(
                  height: 42.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.deepOrangeAccent,
                    color: Colors.deepOrange,
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'

                          ),
                        ),
                      ),
                    )
                  )
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 42.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.0
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Image(image: AssetImage('assets/images/google_logo.png'), color: null, height: 30.0),
                        ),
                        SizedBox(width: 10.0),
                        Center(
                          child: Text('Log in with Google',
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontFamily: 'Montserrat'
                           )),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ),
          SizedBox(height: 15.0),
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
                onTap: () {},
                child: Text('Register',
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