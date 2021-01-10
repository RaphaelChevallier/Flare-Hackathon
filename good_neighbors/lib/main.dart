import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_service.dart';
import 'package:provider/provider.dart';
import 'home_widget.dart';
import 'sign_in.dart';
import 'sign_up.dart';
import 'welcome.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new Signup(),
        '/signin': (BuildContext context) => new Signin(),
        '/home': (BuildContext context) => new Home(),
        '/welcome': (BuildContext context) => new Welcome(),
      },
      home: AuthenticationWrapper(),
      ),
    );
  }
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: <String, WidgetBuilder>{
//         '/signup': (BuildContext context) => new Signup(),
//         '/signin': (BuildContext context) => new Signin(),
//         '/home': (BuildContext context) => new Home(),
//       },
//       home: Welcome(),
//       );
//   }
// }

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return Home();
    }
    return Signin(); //cuz welcome isnt connected straight to profile
  }
}