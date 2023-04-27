import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transo/helpers/sql_helper.dart';
import 'package:transo/provider/local_db_provider.dart';
import 'package:transo/views/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqlHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TransoProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Tanso',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
