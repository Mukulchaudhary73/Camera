import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scan_app/pages/home_page.dart';
import 'package:scan_app/routes/routes.dart';
import 'package:scan_app/pages/login_page.dart';
import 'package:scan_app/utils/custom_firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp(key: Key('MyApp')));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.red),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: MyRoutes.routes,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: CustomFirebaseAuth.checkLoginStatus(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.data == "") {
            return const LoginPage();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const HomePage();
          }
        },
      ),
    );
  }
}
