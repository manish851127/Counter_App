
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project1/Models/user.dart';
import 'package:project1/Pages/home_page.dart';
import 'package:project1/Pages/login_page.dart';
import 'package:project1/Providers/count_provider.dart';
import 'package:project1/Providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentDir= await getApplicationCacheDirectory();
  Hive.init(documentDir.path);
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());

  runApp(
  
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
        ChangeNotifierProvider(create: (_) => CountProvider()..loadCount()),

      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       home: Consumer<UserProvider>(
       builder: (context, userProvider, child) {
          // Redirect based on whether the user is logged in or not
          if (userProvider.user != null) {
            return const HomePage();  // If logged in, go to HomeScreen
          } else {
            return const LoginPage();  // If not logged in, go to LoginScreen
          }
        }),
      // routes: {
      //   '/login': (context)=>const LoginPage(),
      //   '/register': (context)=> const RegisterPage(),
      //   '/home':(context)=> const HomePage(),
      // },
    );
  }
}

