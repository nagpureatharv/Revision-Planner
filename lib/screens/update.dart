import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class update extends StatefulWidget {
  String title;
  String subtitle;
  String date;
  String id;
  update(
      {Key? key,
      required this.id,
      required this.title,
      required this.subtitle,
      required this.date})
      : super(key: key);

  @override
  State<update> createState() => _updateState();
}

// ignore: camel_case_types
class _updateState extends State<update> {
  //--
  TextEditingController titleController = TextEditingController();

  TextEditingController subtitleController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  void updaterevision() async {
    String title = titleController.text.trim();
    String subtitle = subtitleController.text.trim();
    String datestring = dateController.text.trim();

    if (title == "" || subtitle == "" || datestring == "") {
      const snackBar = SnackBar(
        content: Text("Please enter full details!!"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      log("Enter the details");
    } else {
      await FirebaseFirestore.instance
          .collection("revision")
          .doc(widget.id)
          .update({"title": title, "subtitle": subtitle, "date": datestring});

      const snackbar = SnackBar(
        content: Text("Revision Updated"),
        backgroundColor: Colors.blue,
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Revision"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                TextField(
                  controller: titleController..text = widget.title,
                  autocorrect: true,
                  decoration: const InputDecoration(labelText: "Enter title"),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: subtitleController..text = widget.subtitle,
                  autocorrect: true,
                  decoration:
                      const InputDecoration(labelText: "Enter Subtitle"),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: dateController..text = widget.date,
                  decoration: const InputDecoration(
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      dateController.text =
                          formattedDate; //set output date to TextField value.
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CupertinoButton(
                  color: Colors.blue,
                  onPressed: () {
                    updaterevision();
                  },
                  child: const Text("Update Revision"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
