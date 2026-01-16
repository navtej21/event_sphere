import 'package:event_sphere/models/event_model.dart';
import 'package:event_sphere/services/event_service.dart';
import 'package:flutter/material.dart';

class UpdateEventScreen extends StatefulWidget {
  final EventModel event;

  const UpdateEventScreen({
    super.key,
    required this.event,
  });

  @override
  State<UpdateEventScreen> createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController venueController;
  late TextEditingController capacityController;

  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  bool isLoading = false;



  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.event.title ?? '');
    descriptionController =
        TextEditingController(text: widget.event.description ?? '');
    venueController = TextEditingController(text: widget.event.venue ?? '');
    capacityController =
        TextEditingController(text: widget.event.capacity?.toString() ?? '');

    startDate = widget.event.startDate != null
        ? DateTime.tryParse(widget.event.startDate!)
        : DateTime.now();

    endDate = widget.event.endDate != null
        ? DateTime.tryParse(widget.event.endDate!)
        : DateTime.now();

    startTime =
        widget.event.startTime != null ? _parseTime(widget.event.startTime!) : TimeOfDay.now();

    endTime =
        widget.event.endTime != null ? _parseTime(widget.event.endTime!) : TimeOfDay.now();
  }


  TimeOfDay _parseTime(String time) {
    final parts = time.split(":");
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  Future<void> pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => startDate = picked);
  }

  Future<void> pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => endDate = picked);
  }

  Future<void> pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => startTime = picked);
  }

  Future<void> pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: endTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => endTime = picked);
  }



  Future<void> updateEvent() async {
    if (startDate!.isAfter(endDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Start date cannot be after end date")),
      );
      return;
    }

    setState(() => isLoading = true);

    final body = {
      "title": titleController.text,
      "description": descriptionController.text,
      "venue": venueController.text,
      "capacity": int.tryParse(capacityController.text) ?? 0,
      "startDate": startDate!.toIso8601String().split("T").first,
      "endDate": endDate!.toIso8601String().split("T").first,
      "startTime":
          "${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}",
      "endTime":
          "${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}",
    };

    try {
      await EventService.updateEvent(widget.event.eventId!, body);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Event updated successfully")),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
  }



  Future<void> deleteEvent() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Event"),
        content: const Text("This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await EventService.deleteEvent(widget.event.eventId!);
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Event deleted")));
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Event"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: deleteEvent,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Title")),
            const SizedBox(height: 12),
            TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Description")),
            const SizedBox(height: 12),
            TextField(controller: venueController, decoration: const InputDecoration(labelText: "Venue")),
            const SizedBox(height: 12),
            TextField(
              controller: capacityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Capacity"),
            ),
            const SizedBox(height: 16),

            ListTile(
              title: const Text("Start Date"),
              subtitle: Text(startDate!.toString().split(" ").first),
              trailing: const Icon(Icons.calendar_today),
              onTap: pickStartDate,
            ),

            ListTile(
              title: const Text("Start Time"),
              subtitle: Text(startTime!.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: pickStartTime,
            ),

            ListTile(
              title: const Text("End Date"),
              subtitle: Text(endDate!.toString().split(" ").first),
              trailing: const Icon(Icons.calendar_today),
              onTap: pickEndDate,
            ),

            ListTile(
              title: const Text("End Time"),
              subtitle: Text(endTime!.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: pickEndTime,
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: isLoading ? null : updateEvent,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Update Event"),
            ),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    venueController.dispose();
    capacityController.dispose();
    super.dispose();
  }
}
