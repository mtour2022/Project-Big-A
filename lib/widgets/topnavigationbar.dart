import 'package:flutter/material.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/biga.png', height: 40, width: 40),
            Image.asset('assets/images/lgu.png', height: 40, width: 40),
            Image.asset('assets/images/mtour.png', height: 40, width: 40),
          ],
        ),
      ),
    );
  }
}
