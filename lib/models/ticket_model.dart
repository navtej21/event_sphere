import 'dart:ffi';

import 'package:event_sphere/models/event_model.dart';
import 'package:event_sphere/models/user_model.dart';

class TicketModel {
  final int ticketid;

  final EventModel event;
  final UserModel user;
  final int quantity;
  final Float price;
  final String eventfee;
  final String ticketstatus;

  TicketModel(
      {required this.ticketid,
      required this.event,
      required this.user,
      required this.eventfee,
      required this.quantity,
      required this.price,
      required this.ticketstatus});

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
        ticketid: json['ticketid'],
        event: json['event'],
        user: json['user'],
        quantity: json['quantity'],
        price: json['price'],
        ticketstatus: json['pricestatus'], eventfee: json['eventfee']);
  }
}
