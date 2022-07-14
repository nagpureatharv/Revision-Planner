import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revisionplneer1/screens/update.dart';

class upcoming extends StatefulWidget {
  const upcoming({Key? key}) : super(key: key);

  @override
  State<upcoming> createState() => _upcomingState();
}

class _upcomingState extends State<upcoming> {
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("revision")
                      .where("date", isGreaterThan: date)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<Object, dynamic> userMap =
                                  snapshot.data!.docs[index].data()
                                      as Map<Object, dynamic>;

                              return Column(
                                children: [
                                  InkWell(
                                    child: ListTile(
                                      title: Text(
                                        userMap["title"],
                                        style: TextStyle(
                                          color: Colors.green[500],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      subtitle: Text(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          '${"\n" + userMap["subtitle"]}\nDueDate: ' +
                                              userMap["date"],
                                          style: const TextStyle(
                                            color: Colors.black,
                                          )),
                                      trailing: IconButton(
                                        onPressed: () async {
                                          // Delete
                                          var id =
                                              snapshot.data?.docs[index].id;
                                          await FirebaseFirestore.instance
                                              .collection("revision")
                                              .doc(id)
                                              .delete();
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      String? idd =
                                          snapshot.data?.docs[index].id;
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: ((context) => update(
                                                    id: idd.toString(),
                                                    title: userMap["title"],
                                                    subtitle:
                                                        userMap["subtitle"],
                                                    date: userMap["date"],
                                                  ))));
                                    },
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      } else {
                        return const Text("No data!");
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Text(
                                  //   "Due Date: ${userMap[date]}",
                                  //   style: const TextStyle(
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                  // const Divider(
                                  //   color: Colors.grey,
                                  // ),