import 'package:flutter_crud_using_hive_db/Model/entries.dart';
import 'package:hive/hive.dart';

class Controller{

  static Box<Entries> entries() => Hive.box("Entries");

  static addData(Entries ob1){
    Box entry = entries();
    entry.add(ob1);
  }

  static editData(Entries ob2, {required String mail,required String  pass}){
    Entries entries = ob2;
    ob2.email = mail;
    ob2.password = pass;
    ob2.save();
  }

  static deleteData(Entries ob3){
    ob3.delete();
  }

}