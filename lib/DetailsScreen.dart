import 'package:al_zikr/CustomContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final List<dynamic> zikirbenifits;
  const DetailsScreen({super.key, required this.zikirbenifits});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool istrue = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  istrue = !istrue;
                });
              },
              icon: const Icon(Icons.translate))
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.all(size.height * 0.02),
                padding: EdgeInsets.all(size.height * 0.02),
                // height: size.height * 0.15,
                // width: size.width * 0.9,
                decoration: BoxDecoration(
                    color: const Color(0xffDAC0A3),
                    boxShadow: const [
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
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    for (var item in istrue
                        ? widget.zikirbenifits[0]['english']
                        : widget.zikirbenifits[0]['urdu'])
                      Text(
                        istrue
                            ? "\n${item.toString()}\n"
                            : "\t${item.toString()}\n",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'text'),
                      ),
                    // Text("${widget.zikirbenifits[0]['english'][1].toString()}")
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
