class Warfare {
  String? id;
  String? title;
  String? verse;
  String? prayerPoint;
  String? date;

  Warfare({this.id, this.title, this.verse, this.prayerPoint, this.date});

  Warfare.fromJson(Map<String, dynamic> json) {
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




