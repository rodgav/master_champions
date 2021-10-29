import 'package:flutter/material.dart';

class FooterWid extends StatelessWidget {
  final VoidCallback voidCallback;

  const FooterWid({Key? key, required this.voidCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: voidCallback,
        child: const Padding(
            padding: EdgeInsets.all(20), child: Text('RSGM Solutions')),
      ),
    );
  }
}
