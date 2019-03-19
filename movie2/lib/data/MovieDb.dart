import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie2/helper/Tmdb.dart';
import 'package:movie2/model/movieModel.dart';



class MovieDb {

  Future<Movie> fetchNowPlayingMovies() async {
       var response =await http.get(Tmdb.nowPlayingUrl);
       var decodeJson= jsonDecode(response.body);
       return Movie.fromJson(decodeJson) ;
   }

  fetchUpcomingMovies() async {
     var response = await http.get(Tmdb.upcomingUrl);
     var decodedJson = jsonDecode(response.body);
     return Movie.fromJson(decodedJson);
   }

   fetchPopularMovies() async {
     var response = await http.get(Tmdb.popularUrl);
     var decodedJson = jsonDecode(response.body);
     return Movie.fromJson(decodedJson);
   }

   fetchTopRatedMovies() async {
     var response = await http.get(Tmdb.topRatedUrl);
     var decodedJson = jsonDecode(response.body);
     return Movie.fromJson(decodedJson);
   }
}