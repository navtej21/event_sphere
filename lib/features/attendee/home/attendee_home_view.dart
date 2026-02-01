import 'dart:convert';

import 'package:event_sphere/features/attendee/account/account_page.dart';
import 'package:event_sphere/features/attendee/bottombar/bottom_navigation_bar.dart';
import 'package:event_sphere/features/attendee/eventdashboard/event_discover_page.dart';
import 'package:event_sphere/features/attendee/favorite/attendee_favorite_view.dart';
import 'package:event_sphere/features/attendee/tickets/ticket_page_view.dart';
import 'package:event_sphere/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AttendeeScreen extends StatefulWidget {
  const AttendeeScreen({super.key});

  @override
  State<AttendeeScreen> createState() => _AttendeeScreenState();
}

class _AttendeeScreenState extends State<AttendeeScreen> {

   int _selectedIndex=0;


   @override
  void initState() {

    print(SecureStorage.getToken());
    // TODO: implement initState
    
    super.initState();
  }

   

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  final _pages= [
     EventDiscoverPage(),
     AttendeeFavoriteView(),
     TicketPageView(),
     AccountPage()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF8F7F2),
        body: _pages[_selectedIndex],
        
        bottomNavigationBar: BottomNavigationBar(currentIndex: _selectedIndex,onTap: _onItemTapped,items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:"Discover",backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Saved",backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.ticketSimple),label: "Tickets",backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Account",backgroundColor: Colors.black)
        ]),);
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: const TextField(
        decoration: InputDecoration(
      
          hintText: "Search Events",
          prefixIconColor: Colors.black,
          fillColor: Colors.transparent,
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
