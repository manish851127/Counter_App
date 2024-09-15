import 'package:flutter/material.dart';
import 'package:project1/Pages/login_page.dart';
import 'package:project1/Providers/count_provider.dart';
import 'package:project1/Providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String data="No value found";

  @override
  Widget build(BuildContext context) {
    final user= Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<UserProvider>(context, listen: false).logout();
              Navigator.pushReplacement(context,
               MaterialPageRoute(builder: (context)=>const LoginPage()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Welcome, ${user?.username ?? 'Guest'}!',
              style:const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 7,),
            Consumer<CountProvider>(
              builder: (context, counterProvider,child){
                return Column(
              children: [
                Text('Count ${counterProvider.count}', style:const TextStyle(fontSize: 22,color: Colors.black45), ),
                const SizedBox(height: 20,),
                ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white
              ),
              onPressed: () async{
                await counterProvider.increment();

              }, 
              child:const Text("Counter")),
                  ],
                );
              }
              )
            
          ],
        ),
      ),
    );
  }
}