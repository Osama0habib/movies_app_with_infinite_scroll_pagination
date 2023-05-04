class ApiConstance {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiKey = "c00d5b419c51279964254b85bcb419c5";
  static const String nowPlayingMoviesPath = "$baseUrl/movie/now_playing?api_key=$apiKey";
  static String popularMoviesPath(int page) => "$baseUrl/movie/popular?page=$page&api_key=$apiKey";
  static String topRatedMoviesPath(int page) => "$baseUrl/movie/top_rated?page=$page&api_key=$apiKey";
  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";
  static String imageUrl(String path) => "$baseImageUrl$path";
  static String movieDetailsPath(int id) => "$baseUrl/movie/$id?api_key=$apiKey" ;
  static String movieRecommendationPath(int id) => "$baseUrl/movie/$id/recommendations?api_key=$apiKey" ;
}