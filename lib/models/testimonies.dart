class Testimony {
  String? id;
  String? title;
  String? testimony;

  Testimony({this.id, this.title, this.testimony});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['testimony'] = this.testimony;
    return data;
  }
}

