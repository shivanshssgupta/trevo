import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:trevo/Models/places.dart';
import 'package:trevo/shared/colors.dart';
import 'package:trevo/ui/Tiles/placesTile.dart';
import 'package:trevo/utils/placesProvider.dart';

class DisplayPlaces extends StatefulWidget {
  final placesProvider, cityName,locationProvider;

  const DisplayPlaces({Key key, this.placesProvider, this.cityName,this.locationProvider}) : super(key: key);

  @override
  _DisplayPlacesState createState() => _DisplayPlacesState();
}

class _DisplayPlacesState extends State<DisplayPlaces> {
  double width;
  List<Places> places = List();

  @override
  Widget build(BuildContext context) {
    final placesProvider = Provider.of<PlacesProvider>(context);
    width = MediaQuery.of(context).size.width;
    return placesProvider.isLoading() == false
        ? placesProvider.placesAPI.totalCount != null
            ? ListView.builder(
                itemBuilder: (context, index) {
                  final object = placesProvider.placesAPI.places[index];
                  return PlacesTile(
                    attractionName: object.attractionName,
                    imageUrl: object.picture,
                    description: object.description,
                    readMore: object.readMore,
                    distance: object.distance,
                  );
                },
                itemCount: placesProvider.placesAPI.totalCount,
              )
            : Center(
                child: Text(
                    'We don\'t have this city in our database yet! We are working on adding more cities.\n Until then try looking for other cities.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Teal.withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat',
                      fontSize: 22),),
              )
        : Center(child: SpinKitCircle(color: BottleGreen));
  }
}
