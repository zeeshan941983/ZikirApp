import 'package:al_zikr/Backend/provider.dart';
import 'package:al_zikr/Screens/zikir_page.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<ZikirData>(builder: (context, value, child) {
      var getzikir = value.doneZikir
          .where((element) => element['zikir'][0] == value.zikirText);

      // print(value.doneZikir.length);
      // final String b = value.currentzikirdata['zikir']['zikir'][0];
      return Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/bg.png",
                      height: size.height,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.2,
                          vertical: size.height * 0.09),
                      height: size.height * .06,
                      width: size.width / 1.7,
                      decoration: BoxDecoration(
                          color: const Color(0xffEADBC8),
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Zikir_page(
                                        isfromtasbeeh: true,
                                      ))),
                          child: Text(
                            "Select a zikr",
                            style: TextStyle(
                                fontSize: size.height * 0.028,
                                color: const Color(0xff102C57),
                                fontFamily: "text"),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.03,
                          vertical: size.height * 0.20),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.03,
                      ),
                      height: size.height * .2,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xffEADBC8),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(-7, 8),
                            ),
                            BoxShadow(
                              color: Color(0xffFEFAF6),
                              blurRadius: 7,
                              offset: Offset(7, -8),
                            )
                          ]),
                      child: Center(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: size.width * 0.9,
                            maxHeight: size.height * 0.2,
                          ),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  value.zikirText,
                                  style: const TextStyle(
                                      fontSize: 40,
                                      fontFamily: "arabic",
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff102C57)),
                                ),
                                Text(
                                  value.zikirtranslation,
                                  style: const TextStyle(
                                      fontSize: 40,
                                      fontFamily: "Allah",
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff102C57)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.14),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          children: [
                            Positioned(
                              top: size.width * .22,
                              left: size.width * 0.23,
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
                                      value.count.toString(),
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
                              left: size.width * 0.01,
                              bottom: size.height * 0.004,
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
                              child: Text(
                                "الزکر",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * 0.04,
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
                                      value.counting();
                                    },
                                    child: const Text('')),
                              ),
                            ),
                            Positioned(
                              top: size.width * 0.45,
                              left: size.width * 0.48,
                              child: SizedBox(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        fixedSize: MaterialStatePropertyAll(
                                            Size(size.width / 7,
                                                size.height * 0.03)),
                                        shape: const MaterialStatePropertyAll(
                                            CircleBorder()),
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                Color(0xffDAC0A3))),
                                    onPressed: () {
                                      setState(() {
                                        value.count = 0;
                                      });
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
        }),
      );
    });
  }
}
