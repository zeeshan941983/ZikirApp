import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget data;
  const CustomContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(size.height * 0.03),
      height: size.height * 0.15,
      width: size.width * 0.9,
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
      child: data,
    );
  }
}
