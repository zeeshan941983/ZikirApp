import 'package:al_zikr/CustomContainer.dart';
import 'package:al_zikr/DetailsScreen.dart';
import 'package:al_zikr/provider.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Zikir_page extends StatefulWidget {
  const Zikir_page({super.key});

  @override
  State<Zikir_page> createState() => _Zikir_pageState();
}

class _Zikir_pageState extends State<Zikir_page> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<ZikirData>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: const Color(0xffEADBC8),
        appBar: AppBar(backgroundColor: const Color(0xffEADBC8)),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: value.zikirList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final zikir = value.zikirList[index]['zikir'];
                    final urdu = value.zikirList[index]['benefits']['urdu'];
                    final benifits = value.zikirList[index]['benefits'];
                    final english =
                        value.zikirList[index]['benefits']['english'];
                    final translation = value.zikirList[index]['English'];

                    return GestureDetector(
                      onTap: () {
                        value.count = 0;
                        value.getcurrentZikr({
                          'zikir': [
                            zikir,
                            translation,
                            {'count': 0}, // Set the count to 0 initially
                            {
                              "benefits": [urdu, english]
                            }
                          ],
                        });
                        Navigator.pop(context);
                      },
                      child: Stack(
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
                              ],
                            ),
                          ),
                          Positioned(
                              right: size.width / 20,
                              top: size.height * 0.03,
                              child: Container(
                                width: size.width * 0.1,
                                height: size.height * 0.048,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xff102C57),
                                ),
                                child: IconButton(
                                    tooltip: "benefits",
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreen(
                                                    zikirbenifits: [benifits],
                                                  )));
                                    },
                                    icon: const Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    )),
                              ))
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      );
    });
  }
}
