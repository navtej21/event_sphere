import 'package:event_sphere/models/attendee_form_model.dart';
import 'package:event_sphere/models/event_model.dart';
import 'package:event_sphere/modules/ticket_section/attendee_form_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketConfirmationPage extends StatefulWidget {
  final EventModel event;
  final int ticketCount;

  const TicketConfirmationPage({
    super.key,
    required this.event,
    required this.ticketCount,
  });

  @override
  State<TicketConfirmationPage> createState() =>
      _TicketConfirmationPageState();
}

class _TicketConfirmationPageState extends State<TicketConfirmationPage> {

  late List<AttendeeFormModel> attendees;

  @override
  void initState() {
    super.initState();
    attendees = List.generate(
      widget.ticketCount,
      (_) => AttendeeFormModel(email:'',name:''),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime startDate =
        DateTime.parse(widget.event.startDate!);

    final String formattedTitleDate =
        DateFormat('MMMM d').format(startDate);

    final String formattedSubDate =
        DateFormat('EEE, MMM dd').format(startDate);

    final String formattedTime =
        DateFormat('h:mm a').format(
      DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
        int.parse(widget.event.startTime!.split(':')[0]),
        int.parse(widget.event.startTime!.split(':')[1]),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F7F2),
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300,
                    image: widget.event.imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(widget.event.imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedTitleDate,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$formattedSubDate · $formattedTime",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "₹${widget.event.fee}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),


            Text(
              widget.event.description ?? "",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: attendees.length,
                itemBuilder: (context, index) {
                  return AttendeeFormCard(
                    index: index,
                    attendee: attendees[index],
                  );
                },
              ),
            ),


            SizedBox(
              
              width: double.infinity,
              child: ElevatedButton(
                
                
                onPressed: () {
                  
                },
                child: const Text("Confirm Booking"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
