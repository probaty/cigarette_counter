class Counter {
  Counter({required this.date, required this.count});

  Counter.fromJson(Map<String, Object?> json)
      : this(
          date: json['date']! as String,
          count: json['count']! as int,
        );

  final String date;
  final int count;

  Map<String, Object?> toJson() {
    return {
      'title': date,
      'genre': count,
    };
  }
}
