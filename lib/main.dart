import 'package:flutter/material.dart';
import 'package:flutter_crud_using_hive_db/Controller/controller.dart';
import 'package:flutter_crud_using_hive_db/Model/entries.dart';
import 'package:flutter_crud_using_hive_db/ShowData.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

late Box box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
   box = await Hive.openBox("myBox");
   Hive.registerAdapter(EntriesAdapter());
   await Hive.openBox<Entries>("Entries");
  runApp(CrudInHive());
}

class CrudInHive extends StatelessWidget {
  const CrudInHive({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      home: AddEntries(),
    );
  }
}

class AddEntries extends StatefulWidget {
  const AddEntries({super.key});

  @override
  State<AddEntries> createState() => _AddEntriesState();
}

class _AddEntriesState extends State<AddEntries> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> _entryAddKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var displaySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Crud Using Hive : Add Entries"),
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
              ShowData()));
        }, icon: Icon(Icons.dataset_linked))],
      ),
      body: Form(
        key: _entryAddKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              padding: EdgeInsets.all(12),
              width: displaySize.width,
              child: Row(
                children: [
                  Text(
                    "E-mail : ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  SizedBox(
                    width: displaySize.width - 140,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: email,
                      validator: (value) => emailValidator(value),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              width: displaySize.width,
              child: Row(
                children: [
                  Text(
                    "Password : ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  SizedBox(
                    width: displaySize.width - 140,
                    child: TextFormField(
                      controller: password,
                      validator: (value) => passwordValidator(value),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.all(20),
                height: 50,
                width: 120,
                child: ElevatedButton(
                    onPressed: () {
                      if(_entryAddKey.currentState!.validate()){
                        addEntry(mail: email.text, pass: password.text);
                        email.clear();
                        password.clear();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ShowData()));
                      }
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 20),
                    ))),
            Spacer(),

          ],
        ),
      ),
    );
  }

  emailValidator(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return "E-mail can't be empty !!";
    }
  }

  passwordValidator(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return "Password can't be empty !!";
    }
  }

  addEntry({required String mail, required String pass}){
    final rawData = Entries()..email = mail..password = pass;
    Controller.addData(rawData);

  }
}
