import 'package:flutter/material.dart';
import 'package:project1/Pages/home_page.dart';
import 'package:project1/Pages/login_page.dart';
import 'package:project1/Providers/user_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
 final key= GlobalKey<FormState>();
 final emailController=TextEditingController();
  final passController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Center(
          child: Form(
            key: key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               const Text('REGISTER',style: TextStyle(fontSize: 22),),
               const SizedBox(height: 8,),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "username",
                    border: OutlineInputBorder(
                      borderSide:const BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const  BorderSide(
                        width: 1
                      ),
                      borderRadius: BorderRadius.circular(2)
                    )
                    
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please enter value";
                    }
                    else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderSide:const BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const  BorderSide(
                        width: 1
                      ),
                      borderRadius: BorderRadius.circular(2)
                    )
                    
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please enter email address";
                    }
                    else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 8,),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white
                       ),
                       onPressed: () async{
                      if(key.currentState!.validate()){
                        try{
                          await Provider.of<UserProvider>(context,listen: false)
                          .register(
                             emailController.text.toString(),
                             passController.text.toString()
                             );
                              Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context)=>const HomePage()));                           }catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("something went wrong")
                          )
                        );
                        }
                      
                      };
                    }, 
                    child:const Text("register")),
                ),
                  const SizedBox(height: 5,),
                  TextButton(
                onPressed: () {
                Navigator.pushReplacement(context,
               MaterialPageRoute(builder: (context)=>const LoginPage()));;
              },
              child:const Text('Back to Login'),
              ),
              ],
            ),
          ),
         ),
       ),
    );
  }
}