class Results {
  int? id;
  String? title;
  String? name;
  String? description;
  String? userPhoneNumber;
  String? thumbnailUrl;
  String? portraitUrl;
  String? banner;
  String? status;
  String? movieDuration;
  String? created;
  String? background;
  int? viewCount;
  int? totalWatchMinutes;

  Results(
      {this.id,
        this.title,
        this.description,
        this.userPhoneNumber,
        this.thumbnailUrl,
        this.portraitUrl,
        this.status,
        this.banner,
        this.movieDuration,
        this.background,
        this.name,
        this.created,
        this.viewCount,
        this.totalWatchMinutes});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    banner = json['banner'];
    userPhoneNumber = json['userPhoneNumber'];
    background = json['background'];
    description = json['description'];
    thumbnailUrl = json['thumbnail'];
    portraitUrl = json['portrait_url'];
    status = json['status'];
    movieDuration = json['movie_duration'];
    created = json['created'];
    viewCount = json['view_count'];
    totalWatchMinutes = json['total_watch_minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['background'] = this.background;
    data['name'] = this.name;
    data['title'] = this.title;
    data['banner'] = this.banner;
    data['userPhoneNumber'] = this.userPhoneNumber;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnailUrl;
    data['portrait_url'] = this.portraitUrl;
    data['status'] = this.status;
    data['movie_duration'] = this.movieDuration;
    data['created'] = this.created;
    data['view_count'] = this.viewCount;
    data['total_watch_minutes'] = this.totalWatchMinutes;
    return data;
  }
}