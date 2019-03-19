class Tmdb{
  static const apiKey = "22c08026fedd4477ae724051409a9880";
  static const baseUrl = "https://api.themoviedb.org/3/movie/";
  static const baseImagesUrl = "https://image.tmdb.org/t/p/";

  static const nowPlayingUrl = "${baseUrl}now_playing?api_key=$apiKey&language=es-AR&page=1&region=es";
  static const upcomingUrl = "${baseUrl}upcoming?api_key=$apiKey&language=es&page=1";
  static const popularUrl = "${baseUrl}popular?api_key=$apiKey&language=es&page=1";
  static const topRatedUrl = "${baseUrl}top_rated?api_key=$apiKey&language=es&page=1";
}