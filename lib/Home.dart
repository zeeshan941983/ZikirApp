import 'dart:convert';

import 'package:al_zikr/CustomContainer.dart';
import 'package:al_zikr/provider.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List zikirElahiData = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<ZikirData>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: value.doneZikir.length,
                  itemBuilder: (context, index) {
                    var zikir = value.doneZikir[index]['zikir'][0];
                    // var translation = value.doneZikir[index]['zikir'][1];
                    var count = value.doneZikir[index]['zikir'][2]['count'];

                    if (count != null && count > 0) {
                      return Stack(
                        children: [
                          CustomContainer(
                            data: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    zikir,
                                    style: TextStyle(
                                        fontFamily: "arabic",
                                        fontSize: size.height * 0.03),
                                  ),
                                ),
                                Text(value.zikirList[index]['English']),
                                Text(
                                  '$count X',
                                  style: TextStyle(
                                      fontFamily: 'text',
                                      fontSize: size.height * 0.025,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox
                          .shrink(); // Return an empty SizedBox if count is null or 0
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
