import 'package:flutter/material.dart';
import 'package:perfect_plate/bottom_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: FooterButtons(page: "Home"),
    );
  }
}
