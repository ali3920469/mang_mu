import 'package:mang_mu/screens/chat_screen.dart';
import 'package:mang_mu/widgets/my_buttn.dart';
import 'package:flutter/material.dart';

class EsigninScreen extends StatefulWidget {
  static const String screenroot = 'esignin_screen';

  const EsigninScreen({super.key});

  @override
  State<EsigninScreen> createState() => _EsigninScreenState();
}

class _EsigninScreenState extends State<EsigninScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            SizedBox(height: 180, child: Image.asset('images/lbb.jpg')),
            Text('   '),
            Text(''),
            Text(
              '   For The Better Life',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: const Color.fromARGB(255, 48, 217, 230),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (Value) {},
              decoration: InputDecoration(
                hintText: 'Enter Your Email',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 48, 205, 216),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 48, 205, 216),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (Value) {},
              decoration: InputDecoration(
                hintText: 'Enter Your Password',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 48, 205, 216),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 48, 205, 216),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (Value) {},
              decoration: InputDecoration(
                hintText: 'Enter Your Code',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 48, 205, 216),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 158, 202, 56),
                    width: 2,
                  ),

                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),

            SizedBox(height: 10),
            Mybutton(
              color: const Color.fromARGB(255, 48, 205, 216),
              title: 'Sign In',
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.screenroot);
              },
            ),
          ],
        ),
      ),
    );
  }
}
