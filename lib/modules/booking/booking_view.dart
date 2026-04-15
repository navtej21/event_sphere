import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(title: const Text('My Bookings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () {
            if (controller.bookings.isEmpty) {
              return Center(
                child: Text(
                  'No booked events yet',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                ),
              );
            }

            return ListView.separated(
              itemCount: controller.bookings.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final booking = controller.bookings[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(booking.eventTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text('Booked on ${DateFormat.yMMMd().format(booking.bookedAt)}', style: TextStyle(color: Colors.grey.shade600)),
                        const SizedBox(height: 8),
                        Text('Date: ${DateFormat.yMMMd().format(booking.date)}'),
                        const SizedBox(height: 4),
                        Text('Venue: ${booking.venue}'),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
