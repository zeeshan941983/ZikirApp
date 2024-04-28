import 'package:al_zikr/Backend/roomcreate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomMainScreen extends StatefulWidget {
  const RoomMainScreen({super.key});

  @override
  State<RoomMainScreen> createState() => _RoomMainScreenState();
}

class _RoomMainScreenState extends State<RoomMainScreen> {
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
