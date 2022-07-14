import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:revisionplneer1/screens/add_revision.dart';
import 'package:revisionplneer1/screens/login.dart';
import 'package:revisionplneer1/screens/overdue.dart';
import 'package:revisionplneer1/screens/today.dart';
import 'package:revisionplneer1/screens/upcoming.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Overdue",
                icon: Icon(Icons.report_gmailerrorred_outlined),
              ),
              Tab(
                text: "Today",
                icon: Icon(Icons.home_work),
              ),
              Tab(
                text: "Upcoming",
                icon: Icon(Icons.upcoming),
              ),
            ],
          ),
          title: const Text("Revision Planner"),
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: ((context) => const login())));
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: const TabBarView(
          children: [overdue(), today(), upcoming()],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: ((context) => const Add_Revision())));
          },
        ),
      ),
    );
  }
}
