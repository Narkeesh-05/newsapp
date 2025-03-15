import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task/screens/articles_list.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ArticlesList()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.jpg',
              height: screenHeight * 0.15,
              fit: BoxFit.fill,
            ),
            Text(
              'DAILY NEWS',
              style: TextStyle(
                color: HexColor("#1E4684"),
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 25),
            CircularProgressIndicator(color: HexColor("#1E4684")),
          ],
        ),
      ),
    );
  }
}
