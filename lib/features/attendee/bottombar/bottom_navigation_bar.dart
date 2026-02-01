import 'package:event_sphere/features/attendee/bottombar/attendee_bottom_navbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendeeBottomNav extends GetView<AttendeeBottomNavbarController> {
  int _currentIndex = 0;

  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.favorite_border,
    Icons.confirmation_number_outlined,
    Icons.person_outline,
  ];

  final List<String> _labels = [
    'Discover',
    'Saved',
    'Tickets',
    'Account',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.orange,
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 4,
          ),
        ],
      ),
      child: Obx(() {
        return Row(
          children: List.generate(_icons.length, (index) {
            final isSelected = controller.currentindex == index;

            return Expanded(
              child: InkWell(
                onTap: () => controller.changeTab(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 2,
                      width: isSelected ? 24 : 0,
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Colors.deepOrange : Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Icon(
                      _icons[index],
                      size: 24,
                      color: isSelected ? Colors.black : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _labels[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
