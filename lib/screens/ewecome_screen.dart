import 'package:mang_mu/screens/esignin_screen.dart';
import 'package:mang_mu/screens/eregesyer_screen.dart';
import 'package:mang_mu/widgets/my_buttn.dart';
import 'package:flutter/material.dart';


class EwecomeScreen extends StatefulWidget {
  static const String screenroot = 'ewcome_screen';
  const EwecomeScreen({super.key});

  @override
  State<EwecomeScreen> createState() => _EwecomeScreenState();
}

class _EwecomeScreenState extends State<EwecomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SizedBox(height: 180, child: Image.asset('images/lbb.jpg')),
                Text('   '),
                Text(''),
                Text(
                  'For The Better Life',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: const Color.fromARGB(255, 48, 217, 230),
                  ),
                ),
                SizedBox(height: 10),
                 Text(
                  'Employee Registration Page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: const Color.fromARGB(255, 48, 217, 230),
                  ),
                ),
              
              ],
              
            ),
            SizedBox(height: 30),
            Mybutton(
              color: const Color.fromARGB(255, 48, 205, 216),
              title: 'Sign in',
              onPressed: () {
                Navigator.pushNamed(context, EsigninScreen.screenroot);
              },
            ),
            Mybutton(
              color: const Color.fromARGB(255, 166, 216, 48),
              title: 'Sign up',
              onPressed: () {
                Navigator.pushNamed(context,EregesyerScreen .screenroot);
              },
            ),
          ],
        ),
      ),
    );
  }
}
