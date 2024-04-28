import 'package:al_zikr/auth/Services.dart';
import 'package:al_zikr/provider.dart';
import 'package:al_zikr/room/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class LeaderRoomPage extends StatefulWidget {
  @override
  _LeaderRoomPageState createState() => _LeaderRoomPageState();
}

class _LeaderRoomPageState extends State<LeaderRoomPage> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? currentUserData;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserData();
  }

  _loadCurrentUserData() async {
    Map<String, dynamic>? data =
        await Provider.of<AuthService>(context, listen: false)
            .getCurrentUserData();
    setState(() {
      currentUserData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Zikir Room'),
      ),
      body: Consumer<ZikirData>(
        builder: (BuildContext context, value, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          labelText: 'Room Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        await value.createRoom(
                            _controller.text,
                            currentUserData!['username'],
                            auth.currentUser!.uid.toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    zikirRoom(roomid: value.roomid)));
                      },
                      child: const Text('Create Room'),
                    ),
                  ],
                ),
              ),
              if (value.roomid.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Room ID:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value.roomid,
                            style: const TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            icon: const Icon(Icons.content_copy),
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: value.roomid));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Room ID copied to clipboard'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class ParticipantRoomPage extends StatefulWidget {
  @override
  State<ParticipantRoomPage> createState() => _ParticipantRoomPageState();
}

class _ParticipantRoomPageState extends State<ParticipantRoomPage> {
  final TextEditingController _roomIdController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic>? currentUserData;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserData();
  }

  _loadCurrentUserData() async {
    Map<String, dynamic>? data =
        await Provider.of<AuthService>(context, listen: false)
            .getCurrentUserData();
    setState(() {
      currentUserData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Zikir Room'),
      ),
      body: Consumer<ZikirData>(
        builder: (BuildContext context, value, Widget? child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _roomIdController,
                        decoration: const InputDecoration(
                          labelText: 'Room ID',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        value.joinRoom(
                            _roomIdController.text,
                            currentUserData!['username'].toString(),
                            auth.currentUser!.uid.toString());

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    zikirRoom(roomid: _roomIdController.text)));
                      },
                      child: Text('Join Room'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
