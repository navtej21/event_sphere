import 'package:event_sphere/services/string_time_conversion.dart';
import 'package:flutter/material.dart';
import '../../../services/event_service.dart';

class CreateEventScreen extends StatefulWidget {
  final int organizerId;

  const CreateEventScreen({
    super.key,
    required this.organizerId,
  });

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleCtrl = TextEditingController();
  final venueCtrl = TextEditingController();
  final capacityCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  bool loading = false;

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (startDate == null ||
        endDate == null ||
        startTime == null ||
        endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select date & time")),
      );
      return;
    }

    setState(() => loading = true);

    final body = {
      "title": titleCtrl.text,
      "venue": venueCtrl.text,
      "capacity": int.parse(capacityCtrl.text),
      "description": descriptionCtrl.text,
      "startDate": startDate!.toIso8601String().split("T")[0],
      "endDate": endDate!.toIso8601String().split("T")[0],
      "startTime": formatTime(startTime!),
      "endTime": formatTime(endTime!),
      "location": "OFFLINE",
      "visiblity": "PRIVATE",
      "status": "DRAFT"
    };

    print("this is the body of the form data   ${body}");

    await EventService.createEvent(body);

    setState(() => loading = false);
    Navigator.pop(context, true);
  }

  Future<void> pickDate(bool isStart) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        if (isStart) {
          startDate = date;
        } else {
          endDate = date;
        }
      });
    }
  }

  Future<void> pickTime(bool isStart) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        if (isStart) {
          startTime = time;
        } else {
          endTime = time;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          "Create Event",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _input(titleCtrl, "Event Title"),
              _input(venueCtrl, "Venue"),
              _input(capacityCtrl, "Capacity", number: true),
              _input(descriptionCtrl, "Description", maxLines: 3),
              const SizedBox(height: 16),
              _picker("Start Date", startDate, () => pickDate(true)),
              _picker("Start Time", startTime, () => pickTime(true)),
              const SizedBox(height: 8),
              _picker("End Date", endDate, () => pickDate(false)),
              _picker("End Time", endTime, () => pickTime(false)),
              const SizedBox(height: 32),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: loading ? null : submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Create Event",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController controller,
    String label, {
    bool number = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _picker(String label, dynamic value, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        title: Text(label),
        subtitle: Text(
          value == null ? "Select" : value.toString(),
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: const Icon(Icons.calendar_today, color: Colors.black),
        onTap: onTap,
      ),
    );
  }
}
