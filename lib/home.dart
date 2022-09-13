import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:fluttertask/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];
  getdata() async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance.collection("demodata").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        users.add(User(result["name"], result["age"], result["city"]));
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("HomePage"),
          backgroundColor: Colors.blue[900],
          actions: [
            PopupMenuButton(

                itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Sort by Name"),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Sort by Age"),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text("Sort by City"),
                ),
              ];
            }, onSelected: (value) {
              if (value == 0) {
                setState(() {
                  users.sort((a, b) => a.name.compareTo(b.name));
                });
              } else if (value == 1) {
                setState(() {
                  users.sort((a, b) => a.age.compareTo(b.age));
                });
              } else if (value == 2) {
                setState(() {
                  users.sort((a, b) => a.city.compareTo(b.city));
                });
              }
            }),
          ]),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                users[index].name.toString(),
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(users[index].city.toString()),
              leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.green[800],
                  child: Text(
                    users[index].age.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.black,
              height: 1,
              thickness: 1,
            );
          },
          itemCount: users.length),
    );
  }
}
