import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/event_model.dart';
import '../../modules/booking/booking_controller.dart';

class EventDetailView extends StatelessWidget {
  const EventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final event = Get.arguments as Event?;
    final bookingController = Get.find<BookingController>();

    if (event == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Event detail')),
        body: const Center(child: Text('Event details not available.')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(title: const Text('Event detail')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 18, color: Colors.blueGrey),
                        const SizedBox(width: 8),
                        Text(DateFormat.yMMMd().format(event.date)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 18, color: Colors.blueGrey),
                        const SizedBox(width: 8),
                        Expanded(child: Text(event.venue)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(event.description, style: TextStyle(color: Colors.grey.shade800, height: 1.4)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () {
                final isRegistered = bookingController.isRegistered(event.id);
                final isLoading = bookingController.isRegistering.value;

                return SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isRegistered || isLoading
                        ? null
                        : () => bookingController.register(event),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(isRegistered ? 'Already registered' : 'Register'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
