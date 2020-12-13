class RestaurantAPI {
  List<Restaurants> restaurants = [];
  int totalCount;
  int cityID;

  RestaurantAPI({this.restaurants, this.totalCount});

  RestaurantAPI.fromJson(Map<String, dynamic> json) {
    if (json["restaurants"] != null) {
      List restaurantsData = json["restaurants"];
      totalCount = restaurantsData.length;
      for (var item in restaurantsData) {
        restaurants.add(new Restaurants.fromJson(item));
      }
    }
  }
}

class Restaurants {
  String restaurantName;
  String price;
  String imgUrl;
  String bookingUrl;
  String address;
  String rating;
  String cuisine;

  Restaurants(
      {this.restaurantName,
      this.price,
      this.imgUrl,
      this.bookingUrl,
      this.address,
      this.rating,
      this.cuisine});

  Restaurants.fromJson(Map<String, dynamic> json) {
    restaurantName = json["restaurant"]["name"];
    price = json["restaurant"]["currency"] +
        " " +
        json["restaurant"]["average_cost_for_two"].toString();
    bookingUrl = json["restaurant"]["url"];
    address = json["restaurant"]["location"]["locality_verbose"];
    cuisine = json["restaurant"]["cuisines"];
    rating = json["restaurant"]["user_rating"]["aggregate_rating"].toString();
    if (json["restaurant"]["featured_image"] != "") {
      imgUrl=json["restaurant"]["featured_image"];
    } else {
      imgUrl=json["restaurant"]["thumb"];
    }
  }
}
