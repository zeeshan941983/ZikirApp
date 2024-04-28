import 'package:al_zikr/zikir_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class zikirRoom extends StatefulWidget {
  final String roomid;
  const zikirRoom({Key? key, required this.roomid}) : super(key: key);

  @override
  State<zikirRoom> createState() => _zikirRoomState();
}

class _zikirRoomState extends State<zikirRoom> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomid),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("rooms")
            .doc(widget.roomid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;
          List<dynamic> participants = data['participants'];

          String useridFromRoom = data['userid'];
          num totalCount = 0;

          for (var participant in participants) {
            totalCount += participant['count'] ?? 0;
          }
          int CurrentUserCount = 0;
          for (var participant in participants) {
            if (participant['userid'] == auth.currentUser!.uid) {
              CurrentUserCount = participant['count'];
            }
          }
          String totalUser = participants.length.toString();

          return Column(
            children: [
              // useridFromRoom == auth.currentUser!.uid
              //     ? Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Column(
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceAround,
              //               children: [
              //                 Text('Total Users: $totalUser'),
              //                 Text(snapshot.data!['name']),
              //                 Text('Total Zikir: $totalCount'.toString()),
              //               ],
              //             ),
              //           ],
              //         ),
              //       )
              //     : const Text(''),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Total Users: $totalUser'),
                        Text(snapshot.data!['name']),
                        Text('Total Zikir: $totalCount'.toString()),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.14),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          children: [
                            Positioned(
                              top: size.width * .217,
                              left: size.width / 4.45,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.01,
                                    right: size.width * 0.01),
                                height: size.height * 0.063,
                                color: const Color(0xffFEFAF6),
                                width: size.height * 0.145,
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      CurrentUserCount.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontFamily: 'clock'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity(),
                              child: Image.asset(
                                color: const Color(0xffDAC0A3),
                                "assets/cou.png",
                                height: size.height * 0.431,
                              ),
                            ),
                            Positioned(
                              left: 4,
                              bottom: 4,
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity(),
                                child: ColorFiltered(
                                  colorFilter: const ColorFilter.mode(
                                    Colors.black,
                                    BlendMode.modulate,
                                  ),
                                  child: Image.asset(
                                    height: size.height * 0.421,
                                    "assets/cou.png",
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: size.width * .10,
                              left: size.width / 3,
                              child: const Text(
                                "الزکر",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: 'arabic'),
                              ),
                            ),
                            Positioned(
                              top: size.width * .48,
                              left: size.width / 3.8,
                              child: SizedBox(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        fixedSize: MaterialStatePropertyAll(
                                            Size(size.width / 4,
                                                size.height * 0.18)),
                                        shape: const MaterialStatePropertyAll(
                                            CircleBorder()),
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                Color(0xffEADBC8))),
                                    onPressed: () {
                                      updateCurrentUserZikirCount(
                                          snapshot.data!);
                                    },
                                    child: const Text('')),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  void updateCurrentUserZikirCount(DocumentSnapshot roomData) {
    var data = roomData.data() as Map<String, dynamic>;
    List<dynamic> participants = data['participants'];

    for (int i = 0; i < participants.length; i++) {
      if (participants[i]['userid'] == auth.currentUser!.uid) {
        participants[i]['count'] = participants[i]['count'] + 1;
      }
    }

    firestore.collection("rooms").doc(widget.roomid).update({
      // 'count': currentCount,
      'participants': participants,
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Check Internet Connection')),
      );
    });
  }
}
