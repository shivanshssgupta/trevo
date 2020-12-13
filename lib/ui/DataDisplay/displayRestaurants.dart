import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:trevo/Models/restaurants.dart';
import 'package:trevo/shared/colors.dart';
import 'package:trevo/ui/Tiles/restaurantTile.dart';
import 'package:trevo/utils/restaurantsProvider.dart';

class DisplayRestaurants extends StatefulWidget {
  final cityName;

  DisplayRestaurants(this.cityName);

  @override
  _DisplayRestaurantsState createState() => _DisplayRestaurantsState();
}

class _DisplayRestaurantsState extends State<DisplayRestaurants> {
  @override
  Widget build(BuildContext context) {
    RestaurantsProvider restaurantsProvider =
        Provider.of<RestaurantsProvider>(context);
    return Container(
        color: LightGrey,
        child: restaurantsProvider.isLoading() == false
            ? restaurantsProvider.restaurantAPI.totalCount != null &&
                    restaurantsProvider.restaurantAPI.totalCount != 0
                ? ListView.builder(
                    itemBuilder: (_, index) {
                      Restaurants temp =
                          restaurantsProvider.restaurantAPI.restaurants[index];
                      return RestaurantTile(
                        name: temp.restaurantName,
                        address: temp.address,
                        rating: temp.rating,
                        bookingUrl: temp.bookingUrl,
                        imgUrl: temp.imgUrl,
                        cuisine: temp.cuisine,
                        price: temp.price,
                      );
                    },
                    itemCount: restaurantsProvider.restaurantAPI.totalCount,
                  )
                : Center(
                    child: Text(
                      'We don\'t have this city in our database yet! We are working on adding more cities.\n Until then try looking for other cities.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Teal.withOpacity(0.8),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat',
                          fontSize: 22),
                    ),
                  )
            : Center(
                child: SpinKitCircle(color: BottleGreen),
              ));
  }
}
