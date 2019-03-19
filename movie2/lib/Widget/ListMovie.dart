import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie2/Widget/MovieDetail.dart';
import 'package:movie2/helper/Tmdb.dart';
import 'package:movie2/model/movieModel.dart';
import 'package:intl/intl.dart';
import 'package:movie2/helper/Globals.dart' as globals;



class ListMovie extends StatefulWidget{


  final Movie items;
  final String movieListTitle;
  const ListMovie({Key key, this.items,this.movieListTitle}): super(key: key);

  @override
  _ListMovie createState() => new _ListMovie();
}

class _ListMovie extends State<ListMovie>{

  int _currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230.0,
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2)
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 7.0, bottom: 7.0),
                  child: Text(widget.movieListTitle ,
                      style: TextStyle(fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]))
              ),
              Flexible(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: widget.items  == null
                        ? <Widget>[Center(child: CircularProgressIndicator())]
                        : widget.items.results
                        .map((movieItem) =>
                        Padding(
                          padding: EdgeInsets.only(left: 6.0, right: 2.0),
                          child: buildMovieListItem(movieItem),
                        ))
                        .toList(),
                  ))
            ]
        )
    );
  }

  Widget buildMovieListItem(Results movieItem) => Material(
      child: Container(
          width: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(6.0),
                  child: _buildMovieItem(movieItem)),
              Padding(
                padding: EdgeInsets.only(left: 6.0, top: 2.0),
                child: Text(
                  movieItem.title,
                  style: TextStyle(fontSize: 8.0),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 6.0, top: 2.0),
                  child: Text(
                    DateFormat('yyyy')
                        .format(DateTime.parse(movieItem.releaseDate)),
                    style: TextStyle(fontSize: 8.0),
                  ))
            ],
          )));


  Widget _buildMovieItem(Results movieItem) {
    globals.heroTag += 1;
    movieItem.heroTag = globals.heroTag;
    return Material(
        elevation: 30.0,
        child: InkWell(
            onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { return MovieDetail(movie: movieItem); })
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => MovieDetail(movie: movieItem,)
                    )
              );
            },
            child: Hero(
              tag: globals.heroTag,
                child : Image.network(
                    "${Tmdb.baseImagesUrl}w500${movieItem.posterPath}",
                    fit: BoxFit.contain,width: 170.0,height: 140.0,)

//              child: Container(
//                  height: 170.0,
//                  width: 110.0,
//                  child : Image.network(
//                    "${Tmdb.baseImagesUrl}w342${movieItem.posterPath}",
//                    fit: BoxFit.contain)
//              ),
            )
        )
    );
  }

}

