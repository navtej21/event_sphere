import 'package:event_sphere/models/attendee_form_model.dart';
import 'package:flutter/material.dart';

class AttendeeFormCard extends StatelessWidget {
  final int index;
  final AttendeeFormModel attendee;

  const AttendeeFormCard({
    super.key,
    required this.index,
    required this.attendee,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFF8F7F2),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attendee ${index + 1}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            _textField(
              label: "First name*",
              onChanged: (v) => attendee.name = v,
            ),

            _textField(
              label: "Email address*",
              keyboardType: TextInputType.emailAddress,
              onChanged: (v) => attendee.email = v,
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required String label,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
