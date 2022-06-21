class Streak {
  int? id;
  int? streak;
  DateTime? lastRecordedDate;

  Streak({this.id, this.streak, this.lastRecordedDate});

  Map<String, dynamic> toMap() {
    if(id == null) {
      return {
        'id': id,
        'streak': streak,
        'lastRecordedDate': lastRecordedDate?.microsecondsSinceEpoch
      };
    } else {
      return {
        'streak': streak,
        'lastRecordedDate': lastRecordedDate?.millisecondsSinceEpoch
      };
    }
  }
}