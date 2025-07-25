import 'package:mang_mu/screens/chat_screen.dart';
import 'package:mang_mu/screens/regesyer_screen.dart';
import 'package:mang_mu/screens/user_thing.dart';
import 'package:mang_mu/screens/signin_screen.dart';
import 'package:mang_mu/screens/eregesyer_screen.dart';
import 'package:mang_mu/screens/esignin_screen.dart';
import 'package:flutter/material.dart';
import 'screens/wecome_screen.dart';
import 'screens/ewecome_screen.dart';
import 'package:mang_mu/screens/mainscren.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'messageme',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),          
      //home: ChatScreen(),
      initialRoute: Mainscren.screenroot,
      routes: {
        Mainscren.screenroot:(context) => Mainscren(),
        WecomeScreen.screenroot: (context) => WecomeScreen(),
         EwecomeScreen.screenroot: (context) => EwecomeScreen(),
        SigninScreen.screenroot: (context) => SigninScreen(),
        UserThing.screenRoot: (context) => UserThing(),
        RegesyerScreen.screenroot: (context) => RegesyerScreen(),
        EsigninScreen.screenroot: (context) => EsigninScreen(),
        EregesyerScreen.screenroot: (context) => EregesyerScreen(),
        ChatScreen.screenroot: (context) => ChatScreen(),
      },
    );
  }
}
