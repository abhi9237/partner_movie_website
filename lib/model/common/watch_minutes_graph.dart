class WatchMinutesGraph {
  final Map<String, int> data;

  WatchMinutesGraph({required this.data});

  factory WatchMinutesGraph.fromJson(Map<String, dynamic> json) {
    return WatchMinutesGraph(
      data: json.map(
            (key, value) => MapEntry(key, value ?? 0),
      ),
    );
  }

  Map<String, dynamic> toJson() => data;
}
