import 'package:flutter/material.dart';
import 'package:project1/Models/user.dart';
import 'package:hive/hive.dart';

class UserProvider extends ChangeNotifier{
  
  User? _user;
  User? get user=>_user;

  Future<void> register(String username, String password)async{
    final box= await Hive.openBox<User>("userBox");
    if(box.values.any((u)=> u.username== username)){
      throw "Username is already exist";
    
    }
    final newUser=User(username: username, password: password);
    await box.add(newUser);
    _user=newUser;
    notifyListeners();
  }


 // load login status for shared preferences

 Future<void> login(String username, String password) async{
   final box= await Hive.openBox<User>("userBox");
   final user=box.values.firstWhere(
    (u)=> u.username == username && u.password==password,
    orElse: ()=> throw "username or password is incorrect",
    );
    _user=user;
   notifyListeners();
 }

Future<void> loadUser() async{
  
   final box= await Hive.openBox<User>("userBox");
    if(box.values.isNotEmpty){
      _user=box.values.first;
    }
   notifyListeners();
 }

 Future<void> logout() async{
  _user=null;    
   notifyListeners();
 }

  
}