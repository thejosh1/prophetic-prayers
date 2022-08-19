class Career {
  String? id;
  String? title;
  String? verse;
  String? prayerPoint;
  String? date;

  Career({this.id, this.title, this.verse, this.prayerPoint, this.date});

  Career.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    verse = json['verses'];
    prayerPoint = json['prayer_point'];
    date = json['date'];
  }


}
//   static Scripture fromJson(json) => Scripture(
//     id: json['id'],
//     title: json['title'],
//     verse: json['verse'],
//     prayerPoint: json['prayer_point']
//   );
// }




