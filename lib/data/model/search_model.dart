

import 'model.dart';

class RestaurantSearch {
  RestaurantSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) => RestaurantSearch(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String , dynamic> toJson() => {
    "error": error ,
    "founded" : founded ,
    "restaurant" : List<dynamic>.from(restaurants.map((e) => e.toJson()))
  } ;

}


