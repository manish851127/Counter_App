import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CountProvider extends ChangeNotifier{
int _count=0;

int get count=> _count;

Future<void> increment()async{
  final box=await Hive.openBox("appBox");
  _count= (box.get('count')??0) +1;
  await box.put("count", _count);
  notifyListeners();
}


Future<void> loadCount()async{
  final box=await Hive.openBox("appBox");
  _count= box.get('count');
    notifyListeners();
}
}