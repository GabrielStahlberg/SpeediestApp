class ConnectionHistory {
  final id;
  final name;
  final location;
  final duration;
  final downloadAverage;
  final uploadAverage;
  final date;

  ConnectionHistory({this.id, this.name, this.location, this.duration, this.downloadAverage, this.uploadAverage, this.date});

  static ConnectionHistory fromJson(dynamic json) {
    return ConnectionHistory(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      duration: json['durationMinutes'],
      downloadAverage: json['downloadAverage'],
      uploadAverage: json['uploadAverage'],
      date: json['date']
    );
  }
}