class AttendeeFormModel {
  String name;
  String email;

  AttendeeFormModel({
    required this.name,
    required this.email
  });

  Map<String,dynamic> toJson(){
    return {
      'name':name,
      'email':email
    };

  }





  
}