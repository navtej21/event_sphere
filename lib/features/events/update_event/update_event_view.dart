import 'package:event_sphere/models/event_model.dart';
import 'package:event_sphere/services/event_service.dart';
import 'package:flutter/material.dart';

class UpdateEventScreen extends StatefulWidget {
  final EventModel event;

  const UpdateEventScreen({super.key, required this.event});

  @override
  State<UpdateEventScreen> createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController venueController;
  late TextEditingController capacityController;

  late DateTime startDate;
  late DateTime endDate;
  late TimeOfDay startTime;
  late TimeOfDay endTime;

  @override
  void initState() {
    super.initState();

    final e = widget.event;

    titleController = TextEditingController(text: e.title);
    descriptionController = TextEditingController(text: e.description);
    venueController = TextEditingController(text: e.venue);
    capacityController = TextEditingController(text: e.capacity.toString());

    startDate = e.startDate;
    endDate = e.endDate;
    startTime = TimeOfDay.fromDateTime(e.startDate);
    endTime = TimeOfDay.fromDateTime(e.endDate);
  }

  // ================= UPDATE =================
  Future<void> updateEvent() async {
    try {
      final body = {
        "title": titleController.text,
        "description": descriptionController.text,
        "venue": venueController.text,
        "capacity": int.tryParse(capacityController.text) ?? 0,
        "startDate": _combine(startDate, startTime).toIso8601String(),
        "endDate": _combine(endDate, endTime).toIso8601String(),
      };

      await EventService.updateEvent(widget.event.eventId, body);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Event updated successfully")),
      );

      Navigator.pop(context, true);
    } catch (e) {
      _error(e.toString());
    }
  }

  // ================= DELETE =================
  Future<void> deleteEvent() async {
    try {
      await EventService.deleteEvent(widget.event.eventId);

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      _error(e.toString());
    }
  }

  // ================= DATE PICKERS =================
  Future<void> pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  Future<void> pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? startTime : endTime,
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  DateTime _combine(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void _error(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Event"),
        actions: [
          IconButton(icon: const Icon(Icons.done), onPressed: updateEvent),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: confirmDelete,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [

            _sectionTitle("Basic Info"),
            _textField("Title", titleController),
            _textField("Description", descriptionController),
            _textField("Venue", venueController),
            _textField("Capacity", capacityController, number: true),

            const SizedBox(height: 16),
            _sectionTitle("Schedule"),

            _dateTile("Start Date", startDate, () => pickDate(true)),
            _timeTile("Start Time", startTime, () => pickTime(true)),

            _dateTile("End Date", endDate, () => pickDate(false)),
            _timeTile("End Time", endTime, () => pickTime(false)),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ================= WIDGETS =================

  void confirmDelete() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Event"),
        content: const Text("Are you sure you want to delete this event?"),
        actions: [
          TextButton(onPressed: Navigator.of(context).pop, child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteEvent();
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 8),
    child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  );

  Widget _textField(String label, TextEditingController controller, {bool number = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      ),
    );
  }

  Widget _dateTile(String title, DateTime date, VoidCallback onTap) => ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(title),
    subtitle: Text("${date.year}-${date.month}-${date.day}"),
    trailing: const Icon(Icons.edit),
    onTap: onTap,
  );

  Widget _timeTile(String title, TimeOfDay time, VoidCallback onTap) => ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(title),
    subtitle: Text(time.format(context)),
    trailing: const Icon(Icons.edit),
    onTap: onTap,
  );
}