import 'package:mang_mu/screens/wecome_screen.dart';
import 'package:mang_mu/screens/ewecome_screen.dart';
import 'package:mang_mu/widgets/my_buttn.dart';
import 'package:flutter/material.dart';

class Mainscren extends StatefulWidget {
  static const String screenroot = '/mainscren';
  const Mainscren({super.key});

  @override
  State<Mainscren> createState() => _MainscrenState();
}

class _MainscrenState extends State<Mainscren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 180,
                  child: Image.asset(
                    'images/lbb.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'For The Better Life',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 48, 217, 230),
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'Register as a ',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 48, 217, 230),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Citizen',
                        style: TextStyle(
              color: Color.fromARGB(255, 129, 83, 255),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: ' OR ',
                      ),
                      TextSpan(
                        text: 'Employee',
                        style: TextStyle(
                          color: Color.fromARGB(255, 185, 71, 175), // نفس لون زر Employee
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Mybutton(
              color: Color.fromARGB(255, 129, 83, 255),
              title: 'Citizen',
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  WecomeScreen.screenroot,
                );
              },
            ),
            Mybutton(
              color: Color.fromARGB(255, 185, 71, 175),
              title: 'Employee',
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  EwecomeScreen.screenroot,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}