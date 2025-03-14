import 'package:flutter/material.dart';

class PayingScreen extends StatelessWidget {
  const PayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(child: Text("paying",style: TextStyle(color: Colors.white),),),
    );
  }
}
