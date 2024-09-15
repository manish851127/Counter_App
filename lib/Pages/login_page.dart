import 'package:flutter/material.dart';
import 'package:project1/Pages/home_page.dart';
import 'package:project1/Pages/registered_page.dart';
import 'package:project1/Providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                const Text('LOGIN',style: TextStyle(fontSize: 22),),
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
                      return "Please enter email address";
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
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      foregroundColor: Colors.white,
                      
                    ),
                    onPressed: () async{
                      if(key.currentState!.validate()){
                        try{
                          await Provider.of<UserProvider>(context,listen: false)
                          .login(
                            emailController.text,
                             passController.text
                             );
                             Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context)=>const HomePage()));
                           }catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Hey, some error"),
                          )
                        );
                        }
                      }
                    }, 
                    child:const Text("SignIn")),
                ),
                 const SizedBox(height: 5,),
                 TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context)=>const RegisterPage()));
                  }, 
                  child:const Text("Register"),
                  )

              ],
            ),
          ),
         ),
       ),
    );
  }
}