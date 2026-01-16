import 'package:event_sphere/models/user_model.dart';

class EventModel {
  final int? eventId;
  final String? title;
  final String? description;
  final String? startDate;
  final String? startTime;
  final String? endDate;
  final String? endTime;
  final String? venue;
  final int? capacity;
  final String? imageUrl;
  final String? category;
  final UserModel? user;
  final String? status;
  final double? fee;
  final String? location;
  final String? visibility;
  final String? fee_type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EventModel({
    this.eventId,
    this.title,
    this.description,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.venue,
    this.capacity,
    this.imageUrl,
    this.category,
    this.user,
    this.status,
    this.location,
    this.visibility,
    this.createdAt,
    this.updatedAt,
    this.fee,
    this.fee_type
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['eventId'],
      title: json['title'],
      description: json['description'],
      startDate: json['startDate'],
      startTime: json['startTime'],
      endDate: json['endDate'],
      endTime: json['endTime'],
      venue: json['venue'],
      fee:json['Fee'],
      fee_type:json['FeeType'],
      capacity: json['capacity'],
      imageUrl: json['imageurl'], 
      category: json['category']?.toString(),

      user: json['organizer'] != null
          ? UserModel.fromJson(json['organizer'])
          : null,

      status: json['status'],
      location: json['location'],
      visibility: json['visibility'], 
      
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,

      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}
