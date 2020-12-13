import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:trevo/Models/hotels.dart';
import 'package:trevo/shared/colors.dart';
import 'package:trevo/ui/Tiles/hotelTile.dart';
import 'package:trevo/utils/hotelsProvider.dart';

class DisplayHotels extends StatefulWidget {
  final hotelsProvider;

  const DisplayHotels({Key key, this.hotelsProvider}) : super(key: key);

  @override
  _DisplayHotelsState createState() => _DisplayHotelsState();
}

class _DisplayHotelsState extends State<DisplayHotels> {
  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelsProvider>(context);

    return Container(
      color: LightGrey,
      child: hotelProvider.isLoading() == false
          ? hotelProvider.hotelAPI.totalCount != 0 &&
                  hotelProvider.hotelAPI.totalCount != null
              ? ListView.builder(
                  itemBuilder: (_, index) {
                    Hotels temp = hotelProvider.hotelAPI.hotels[index];
                    return HotelTile(
                      hotelName: temp.hotelName,
                      imgUrl: temp.imgUrls,
                      hotelPrice: temp.price,
                      bookingUrl: temp.bookingUrl,
                    );
                  },
                  itemCount: hotelProvider.hotelAPI.totalCount,
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
            ),
    );
  }
}
