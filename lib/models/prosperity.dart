class ProsperityScripture {
  String? id;
  String? title;
  String? verse;
  String? prayerPoint;
  String? data;

  ProsperityScripture({this.id, this.title, this.verse, this.prayerPoint, this.data});

  ProsperityScripture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    verse = json['verse'];
    prayerPoint = json['prayerPoint'];
    data = json['date'];
  }
}