import 'dart:ui';

class User {
  String name;
  String email;
  String password;
  String phonenumber;
  String imagePath;

  User({required this.name, required this.email, required this.imagePath, required this.password, required this.phonenumber});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phonenumber'] = this.phonenumber;
    data['imagePath'] = this.imagePath;
    return data;
  }
}