import 'package:al_zikr/room/roomcreate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoomMainScreen extends StatefulWidget {
  const RoomMainScreen({super.key});

  @override
  State<RoomMainScreen> createState() => _RoomMainScreenState();
}

class _RoomMainScreenState extends State<RoomMainScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ParticipantRoomPage())),
              child: const Text('Join Room')),
          TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LeaderRoomPage())),
              child: const Text('Create Room')),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: firestore.collection("rooms").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs;

                          return ListTile(
                            title: Text(data[index]['id'].toString()),
                            subtitle: Text(
                                "Created by : ${data[index]['leader'].toString()}"),
                            trailing: IconButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: data[index]['id'].toString()));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Room ID copied to clipboard'),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.copy)),
                          );
                        }),
                  );
                }

                return const Center(
                    child: Text('Unfortunately No Room available '));
              })
        ],
      ),
    );
  }
}
