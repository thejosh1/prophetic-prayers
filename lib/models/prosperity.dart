class ProsperityScripture {
  String? id;
  String? title;
  String? verse;
  String? prayerPoint;
  String? date;

  ProsperityScripture({this.id, this.title, this.verse, this.prayerPoint, this.date});

  ProsperityScripture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    verse = json['verses'];
    prayerPoint = json['prayer_point'];
    date = json['date'];
  }


}