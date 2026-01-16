import 'package:flutter/material.dart';

class AttendeeFavoriteView extends StatefulWidget {
  const AttendeeFavoriteView({super.key});

  @override
  State<AttendeeFavoriteView> createState() => _AttendeeFavoriteViewState();
}

class _AttendeeFavoriteViewState extends State<AttendeeFavoriteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),
      body: Center(child: Text("Favorite Events"),),
    );
  }
}