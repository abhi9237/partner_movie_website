class Movie {
  final String movieName;
  final String releaseDate;
  final int totalViews;
  final int watchTime; // in minutes
  final double completionRate;
  final double earnings;
  final String status;

  Movie({
    required this.movieName,
    required this.releaseDate,
    required this.totalViews,
    required this.watchTime,
    required this.completionRate,
    required this.earnings,
    required this.status,
  });
}
