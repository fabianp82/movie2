import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:movie2/helper/Tmdb.dart';
import 'package:movie2/model/MovieDetailModel.dart';
import 'package:movie2/model/movieModel.dart';


class MovieDetail extends StatefulWidget{

  final Results movie;
  MovieDetail({this.movie});

  @override
  _MovieDetail createState() => new _MovieDetail();

}

class _MovieDetail extends State<MovieDetail> {

  String movieDetailUrl;
  String movieCreditsUrl;
  MovieDetailModel movieDetails;


  @override
  initState() {
    super.initState();
    movieDetailUrl = "${Tmdb.baseUrl}${widget.movie.id}?api_key=${Tmdb.apiKey}&language=es";
    movieCreditsUrl = "${Tmdb.baseUrl}${widget.movie.id}/credits?api_key=${Tmdb.apiKey}&language=es";
    _fetchMovieDetails();

  }

  void _fetchMovieDetails() async {
    var response = await http.get(movieDetailUrl);
    var decodedJson = jsonDecode(response.body);
    setState(() {
      movieDetails = MovieDetailModel.fromJson(decodedJson);
    });
  }

  String _getMovieDuration(int runtime) {
    if (runtime == null) return 'No data';
    double movieHours = runtime / 60;
    int movieMinutes = ((movieHours - movieHours.floor()) * 60).round();
    return "${movieHours.floor()}h ${movieMinutes}min";
  }

  @override
  Widget build(BuildContext context) {

    final moviePoster = Container(
        height: 350.0,
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Center(
            child: Card(
                elevation: 15.0,
                child: Hero(
                  tag: widget.movie.heroTag,
                  child: Image.network(
                    "${Tmdb.baseImagesUrl}w342${widget.movie.posterPath}",
                    fit: BoxFit.cover,
                  ),
                ))));

    final movieTitle = Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
      child: Center(
          child: Text(
            widget.movie.title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          )),
    );

    final movieTickets = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          movieDetails != null ? _getMovieDuration(movieDetails.runtime) : '',
          style: TextStyle(fontSize: 11.0),
        ),
        Container(
          height: 20.0,
          width: 1.0,
          color: Colors.white70,
        ),
        Text(
          "Relese Date: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.movie.releaseDate))}",
          style: TextStyle(fontSize: 11.0),
        ),
        RaisedButton(
          shape: StadiumBorder(),
          elevation: 15.0,
          color: Colors.red[700],
          child: Text('Tickets'),
          onPressed: () {},
        )
      ],
    );

    final genresList = Container(
        height: 25.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: movieDetails == null
                ? []
                : movieDetails.genres
                .map((g) => Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: FilterChip(
                backgroundColor: Colors.yellow[600],
                labelStyle: TextStyle(fontSize: 10.0),
                label: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(g.name,style: TextStyle(color: Colors.black),),
                ),
                onSelected: (b) {},
              ),
            ))
                .toList(),
          ),
        ));

    final middleContent = Container(
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(),
            genresList,
            Divider(),
            Text(
              'SINOPSIS',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey[300]),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              widget.movie.overview,
              style: TextStyle(color: Colors.grey[300], fontSize: 11.0),
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        ));


    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Movies Fab',
          style: TextStyle(
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: <Widget>[
          moviePoster,
          movieTitle,
          movieTickets,
          middleContent,
      ]),
    );
  }

}


