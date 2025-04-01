import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerRad35 extends StatelessWidget {
  const ContainerRad35({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(35),
      elevation: 5,
      child: Container(
        width: double.infinity, // Đặt full width
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: child,
      ),
    );
  }
}

