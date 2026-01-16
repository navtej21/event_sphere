class EventDescriptionModel {
  final int id;
  final String title;
  final String description;

  EventDescriptionModel({required this.id,required this.title,required this.description});


  factory EventDescriptionModel.fromJson(Map<String, dynamic> json) {
    return EventDescriptionModel(
      id: json['eventId'],
      title: json['title'],
      description: json['description'],
    );
  }
}