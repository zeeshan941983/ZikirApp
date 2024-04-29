import 'package:al_zikr/Backend/auth/Services.dart';
import 'package:al_zikr/Backend/provider.dart';
import 'package:al_zikr/room/Room.dart';
import 'package:al_zikr/Screens/zikir_page.dart';
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
  final TextEditingController distination = TextEditingController();
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Zikir Room'),
      ),
      body: Consumer<ZikirData>(
        builder: (BuildContext context, value, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Zikir_page(
                                  isfromtasbeeh: false,
                                ))),
                    child: Text(
                      value.selectRoomZikir == ''
                          ? "Select a zikr"
                          : "Zikir : ${value.selectRoomZikir}",
                      style: TextStyle(
                          fontSize: size.height * 0.028,
                          color: const Color(0xff102C57),
                          fontFamily: "text"),
                    )),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Room Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: distination,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Select Distination',
                    border: OutlineInputBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (distination.text != '' &&
                        _controller.text != '' &&
                        value.selectRoomZikir != '') {
                      await value.createRoom(
                        _controller.text,
                        currentUserData!['username'],
                        auth.currentUser!.uid.toString(),
                        int.parse(distination.text),
                        value.selectRoomZikir,
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  zikirRoom(roomid: value.roomid)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Fill data"),
                        backgroundColor: Colors.red,
                      ));
                    }
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Room Created Sucessfully"),
                      backgroundColor: Colors.green,
                    ));
                  },
                  child: const Text('Create Room'),
                ),
                // if (value.roomid.isNotEmpty)
                //   Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const Text(
                //           'Room ID:',
                //           style: TextStyle(
                //               fontSize: 16, fontWeight: FontWeight.bold),
                //         ),
                //         const SizedBox(height: 5),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               value.roomid,
                //               style: const TextStyle(fontSize: 18),
                //             ),
                //             IconButton(
                //               icon: const Icon(Icons.content_copy),
                //               onPressed: () {
                //                 Clipboard.setData(
                //                     ClipboardData(text: value.roomid));
                //                 ScaffoldMessenger.of(context).showSnackBar(
                //                   const SnackBar(
                //                     content: Text('Room ID copied to clipboard'),
                //                   ),
                //                 );
                //               },
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
              ],
            ),
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
