import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Add_Revision extends StatefulWidget {
  const Add_Revision({Key? key}) : super(key: key);

  @override
  State<Add_Revision> createState() => _Add_RevisionState();
}

class _Add_RevisionState extends State<Add_Revision> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController dateController1 = TextEditingController();
  TextEditingController dateController2 = TextEditingController();

  void createrevision() async {
    String title = titleController.text.trim();
    String subtitle = subtitleController.text.trim();
    String datestring = dateController.text.trim();
    String datestring1 = dateController1.text.trim();
    String datestring2 = dateController2.text.trim();

    if (title == "" ||
        subtitle == "" ||
        datestring == "" ||
        datestring1 == "") {
      const snackBar = SnackBar(
        content: Text("Please enter full details!!"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      log("Enter the details");
    } else {
      await FirebaseFirestore.instance
          .collection("revision")
          .add({"title": title, "subtitle": subtitle, "date": datestring});

      await FirebaseFirestore.instance
          .collection("revision")
          .add({"title": title, "subtitle": subtitle, "date": datestring1});

      await FirebaseFirestore.instance
          .collection("revision")
          .add({"title": title, "subtitle": subtitle, "date": datestring2});

      const snackbar = SnackBar(
        content: Text("Revision Created"),
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
        title: const Text("Add Revision"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: SafeArea(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: subtitleController,
                  decoration: const InputDecoration(labelText: "Subtitle"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                      labelText: "1st-Revision" //label text of field
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
                      setState(() {
                        dateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: dateController1,
                  decoration: const InputDecoration(
                      labelText: "2nd-Revision" //label text of field
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
                      setState(() {
                        dateController1.text =
                            formattedDate; //set output date to TextField value.
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: dateController2,
                  decoration: const InputDecoration(
                    labelText: "3rd-Revision", //label text of field
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
                      setState(() {
                        dateController2.text =
                            formattedDate; //set output date to TextField value.
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                  color: Colors.blue,
                  onPressed: () {
                    createrevision();
                  },
                  child: const Text("Create Revision"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
