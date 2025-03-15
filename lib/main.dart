import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task/screens/welcome_screen.dart';
import 'package:task/service/api_service.dart';
import 'bloc/article_bloc.dart';
import 'bloc/article_event.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ArticleBloc(NewsService())..add(FetchArticles()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Reader App',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: HexColor("#1E4684"),
          onPrimary: Colors.black,
          secondary: Colors.grey,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}
