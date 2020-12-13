import 'package:trevo/shared/globalFunctions.dart';

class HotelAPI {
  List<Hotels> hotels=[];
  int totalCount;

  HotelAPI({this.hotels, this.totalCount});

  HotelAPI.fromJson(Map<String, dynamic> json) {
    if (json["places"] != null) {
      List hotelsData = json["places"];
      totalCount = hotelsData.length;
      for(var item in hotelsData)
        {
          hotels.add(new Hotels.fromJson(item));
        }
    }
  }
}

class Hotels{
  String hotelName;
  String price;
  List imgUrls;
  String bookingUrl;

  Hotels({this.hotelName,this.price,this.imgUrls,this.bookingUrl});

  Hotels.fromJson(Map<String, dynamic> json) {
    hotelName = json["hotelName"];
    price = dollarToIntPriceConversion(json["price"]);
    imgUrls = json["pictures"];
    bookingUrl = json["viewDealLink"];
  }

}