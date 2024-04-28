import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class ZikirData extends ChangeNotifier {
  List<dynamic> zikirList = [];
  String zikirText = 'Select zikir';
  String zikirtranslation = 'translation';
  int count = 0;
  String userid = '';
  String roomid = 'no id';
  List<dynamic> doneZikir = [];
  var uuid = Uuid();
/////
  int totalZikir = 0;
  int destinationZikir = 100;
  List<dynamic> participants = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///

  ZikirData() {
    loadZikirElahiData();
    loadsaveZikir();
    loadParticipants();
  }
  Future<void> counting() async {
    // var getzikir =
    //     doneZikir.where((element) => element['zikir'][0] == zikirText).toList();

    var existingZikirIndex = doneZikir.indexWhere((element) =>
        element['zikir'][0] == zikirText &&
        element['zikir'][1] == zikirtranslation);

    if (existingZikirIndex != -1) {
      doneZikir[existingZikirIndex]['zikir'][2]['count'] =
          (doneZikir[existingZikirIndex]['zikir'][2]['count'] ?? 0) + 1;
      saveZikir();
    }
    // print(getzikir[0]['zikir'][2]['count']);
    count++;
    notifyListeners();
  }

  Future<void> getcurrentZikr(Map<String, dynamic> zikirData) async {
    String zikirDataJson = jsonEncode(zikirData);
    zikirText = zikirData['zikir'][0];
    zikirtranslation = zikirData['zikir'][1];

    if (!doneZikir.any((element) => jsonEncode(element) == zikirDataJson)) {
      doneZikir.add(zikirData);
      saveZikir();
    }

    notifyListeners();
  }

  Future<void> saveZikir() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String doneZikirJsonList = jsonEncode(doneZikir);
    List<String> current = [zikirText, zikirtranslation];
    pref.setStringList('current', current);
    pref.setString('zikirlist', doneZikirJsonList);
    notifyListeners();
  }

  Future<void> loadsaveZikir() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    zikirText = pref.getStringList('current')![0];
    zikirtranslation = pref.getStringList('current')![1];

    String? currentdataJsonList = pref.getString('zikirlist');
    if (currentdataJsonList != null && currentdataJsonList.isNotEmpty) {
      doneZikir = jsonDecode(currentdataJsonList) as List<dynamic>;
    }
    notifyListeners();
  }

  Future<void> loadZikirElahiData() async {
    final String response = await rootBundle.loadString('assets/jsondata.json');
    final data = json.decode(response);
    zikirList = data['zikir_elahi'];
    notifyListeners();
  }

  /////////room
  Future<void> createRoom(
      String roomName, String leaderName, String userid) async {
    CollectionReference rooms = _firestore.collection('rooms');
    DocumentReference roomRef = rooms.doc();
    String roomId = roomRef.id;
    var data = rooms.where("userid", isEqualTo: userid);
    print(data);
    participants = [
      {
        'id': roomId,
        'userid': userid,
        'name': leaderName,
        'count': 0,
        "join": "true",
      }
    ];
    await roomRef.set({
      'name': roomName,
      'leader': leaderName,
      'id': roomId,
      "userid": userid,
      'participants': participants,
    });

    roomid = roomRef.id;

    saveParticipants();
    notifyListeners();
  }

  Future<void> joinRoom(
      String roomId, String participantName, String userid) async {
    DocumentReference roomRef = _firestore.collection('rooms').doc(roomId);

    try {
      DocumentSnapshot roomSnapshot = await roomRef.get();
      if (roomSnapshot.exists) {
        participants = List.from(roomSnapshot['participants']);

        bool isParticipantExist =
            participants.any((participant) => participant['userid'] == userid);
        if (!isParticipantExist) {
          participants.add({
            'id': roomId,
            'userid': userid,
            'name': participantName,
            'count': 0,
            "join": "true",
          });

          roomRef.update({
            'participants': participants,
          });

          saveParticipants();
          notifyListeners();
        }
      } else {
        print('Room does not exist');
      }
    } catch (e) {
      print('Error joining room: $e');
    }
  }

  Future<void> loadParticipants() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? participantsJsonList = pref.getString('participants');
    if (participantsJsonList != null && participantsJsonList.isNotEmpty) {
      participants = jsonDecode(participantsJsonList) as List<dynamic>;
    }
    notifyListeners();
  }

  void incrementZikir(Map<String, dynamic> participant) {
    int count = participant['count'] ?? 0;
    count++;
    participant['count'] = count;

    totalZikir++;
    saveParticipants();
    notifyListeners();
  }

  Future<void> saveParticipants() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String participantsJsonList = jsonEncode(participants);
    pref.setString('participants', participantsJsonList);
    notifyListeners();
  }

  ////room firebase
}
