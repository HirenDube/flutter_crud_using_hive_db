import 'package:flutter/material.dart';
import 'package:flutter_crud_using_hive_db/Controller/controller.dart';
import 'package:flutter_crud_using_hive_db/Model/entries.dart';
import 'package:hive_flutter/adapters.dart';

class ShowData extends StatefulWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ShowData"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ValueListenableBuilder<Box<Entries>>(
        valueListenable: Controller.entries().listenable(),
        builder: (BuildContext context, box, Widget? child) {
          final entries = box.values.toList().cast<Entries>();
          entries.forEach((element) {
            print("Email = ${element.email}\n"
                "Password = ${element.password}");
          });

          return Center(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Data Table In Flutter",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          DataTable(
                              border: TableBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  top: BorderSide(color: Colors.deepPurple, width: 2),
                                  bottom:
                                  BorderSide(color: Colors.deepPurple, width: 2),
                                  left: BorderSide(color: Colors.deepPurple, width: 2),
                                  right: BorderSide(color: Colors.deepPurple, width: 2),
                                  verticalInside:
                                  BorderSide(color: Colors.amber, width: 2),
                                  horizontalInside:
                                  BorderSide(color: Colors.cyan, width: 2)),
                              columns: const [
                                DataColumn(label: Text("E- mail")),
                                DataColumn(label: Text("Password"))
                              ],
                              rows: List.generate(
                                  entries.length,
                                      (index) => DataRow(
                                          onLongPress: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Controller.editData(
                                                                  entries[index],
                                                                  mail: mail.text,
                                                                  pass: pass.text);
                                                              mail.clear();
                                                              pass.clear();
                                                              Navigator.pop(context);
                                                            },
                                                            child: Text("Edit")),
                                                        TextButton(
                                                            onPressed: () {
                                                              Controller.deleteData(entries[index]);
                                                              Navigator.pop(context);
                                                            },
                                                            child: Text("Delete")),
                                                      ],
                                                      title: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 50,
                                                            width: 230,
                                                            child: TextFormField(
                                                              decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                  "Email"),
                                                              controller: mail,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 50,
                                                            width: 230,
                                                            child: TextFormField(
                                                              decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                  "Password"),
                                                              controller: pass,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ));
                                          },
                                          cells: [
                                            DataCell(Text("${entries[index].email}")),
                                            DataCell(Text("${entries[index].password}"))
                                          ]))),
                          Text(
                            "Noramal Table In Flutter",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Table(
                            border: TableBorder(
                                borderRadius: BorderRadius.circular(15),
                                top: BorderSide(color: Colors.deepPurple, width: 2),
                                bottom: BorderSide(color: Colors.deepPurple, width: 2),
                                left: BorderSide(color: Colors.deepPurple, width: 2),
                                right: BorderSide(color: Colors.deepPurple, width: 2),
                                verticalInside:
                                BorderSide(color: Colors.amber, width: 2),
                                horizontalInside:
                                BorderSide(color: Colors.cyan, width: 2)),
                            children: [
                              TableRow(children: [Text("Email"), Text("Pass wrod")]),
                              ...List.generate(
                                  entries.length,
                                      (index) => TableRow(children: [
                                        Text("${entries[index].email}"),
                                        Text("${entries[index].password}")
                                      ]))
                            ],
                          )
                        ],
                      ))
                ],
              ));
        },
      ),
    );
  }
}
