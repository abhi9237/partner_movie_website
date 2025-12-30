import '../common/demographics.dart';
import '../common/watch_minutes_graph.dart';

class PartnerMovieDetailResponse {
  int? id;
  String? title;
  String? description;
  String? starring;
  String? rating;
  String? creators;
  String? ageGroup;
  String? status;
  int? year;
  String? categoryName;
  String? portraitUrl;
  String? originalPortraitFile;
  String? thumbnailUrl;
  String? originalThumbnailFile;
  int? watchMinutes;
  WatchMinutesGraph? watchMinutesGraph;
  int? uniqueViewCount;
  int? viewCount;
  WatchMinutesGraph? viewCountGraph;
  Demographics? demographics;
  String? created;
  int? mediaId;
  int? rentalCount;

  PartnerMovieDetailResponse({
    this.id,
    this.title,
    this.description,
    this.starring,
    this.rating,
    this.creators,
    this.ageGroup,
    this.status,
    this.year,
    this.categoryName,
    this.portraitUrl,
    this.originalPortraitFile,
    this.thumbnailUrl,
    this.originalThumbnailFile,
    this.watchMinutes,
    this.watchMinutesGraph,
    this.uniqueViewCount,
    this.viewCount,
    this.viewCountGraph,
    this.demographics,
    this.created,
    this.mediaId,
    this.rentalCount,
  });

  PartnerMovieDetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    starring = json['starring'];
    rating = json['rating'];
    creators = json['creators'];
    ageGroup = json['age_group'];
    status = json['status'];
    year = json['year'];
    categoryName = json['category_name'];
    portraitUrl = json['portrait_url'];
    originalPortraitFile = json['original_portrait_file'];
    thumbnailUrl = json['thumbnail_url'];
    originalThumbnailFile = json['original_thumbnail_file'];
    watchMinutes = json['watch_minutes'];
    watchMinutesGraph = json['watch_minutes_graph'] != null
        ? WatchMinutesGraph.fromJson(json['watch_minutes_graph'])
        : null;
    uniqueViewCount = json['unique_view_count'];
    viewCount = json['view_count'];
    viewCountGraph = json['view_count_graph'] != null
        ? WatchMinutesGraph.fromJson(json['view_count_graph'])
        : null;
    demographics = json['demographics'] != null
        ? Demographics.fromJson(json['demographics'])
        : null;
    created = json['created'];
    mediaId = json['media_id'];
    rentalCount = json['rental_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['starring'] = starring;
    data['rating'] = rating;
    data['creators'] = creators;
    data['age_group'] = ageGroup;
    data['status'] = status;
    data['year'] = year;
    data['category_name'] = categoryName;
    data['portrait_url'] = portraitUrl;
    data['original_portrait_file'] = originalPortraitFile;
    data['thumbnail_url'] = thumbnailUrl;
    data['original_thumbnail_file'] = originalThumbnailFile;
    data['watch_minutes'] = watchMinutes;
    if (watchMinutesGraph != null) {
      data['watch_minutes_graph'] = watchMinutesGraph!.toJson();
    }
    data['unique_view_count'] = uniqueViewCount;
    data['view_count'] = viewCount;
    if (viewCountGraph != null) {
      data['view_count_graph'] = viewCountGraph!.toJson();
    }
    if (demographics != null) {
      data['demographics'] = demographics!.toJson();
    }
    data['created'] = created;
    data['media_id'] = mediaId;
    data['rental_count'] = rentalCount;
    return data;
  }
}
