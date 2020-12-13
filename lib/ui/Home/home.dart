import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trevo/shared/colors.dart';
import 'package:trevo/ui/Home/pages/dashboard.dart';
import 'package:trevo/ui/Home/pages/feed.dart';
import 'package:trevo/ui/Home/pages/profile.dart';
import 'package:trevo/ui/TrevoBot/chat.dart';
import 'package:trevo/utils/locationProvider.dart';
import 'package:trevo/utils/placesProvider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:trevo/shared/globalFunctions.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("on: $message");
        final notification = message['notification'];
        try {
          Future.delayed(Duration.zero, () {
            showNormalFlashBar(
                notification['title'], notification['body'], context);
          });
        } catch (e) {
          print(e);
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    currentIndex = 0;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProviderClass>(context);
    final placesProvider = Provider.of<PlacesProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
          backgroundColor: LightGrey,
          floatingActionButton: FloatingActionButton(
              heroTag: 'animation2',
              elevation: 10,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ChatBot()));
              },
              child: FlareActor('assets/botra.flr',
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                  animation: "Alarm"),
              backgroundColor: White,
              tooltip: "Access Assistant"),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BubbleBottomBar(
            items: <BubbleBottomBarItem>[
              BubbleBottomBarItem(
                backgroundColor: BottleGreen,
                icon: Icon(
                  Icons.dashboard,
                  color: BottleGreen,
                ),
                activeIcon: Icon(
                  Icons.dashboard,
                  color: BottleGreen,
                ),
                title: Text('Home'),
              ),
              BubbleBottomBarItem(
                backgroundColor: BottleGreen,
                icon: Icon(
                  Icons.create,
                  color: BottleGreen,
                ),
                activeIcon: Icon(
                  Icons.create,
                  color: BottleGreen,
                ),
                title: Text('MyFeed'),
              ),
              BubbleBottomBarItem(
                backgroundColor: BottleGreen,
                icon: Icon(
                  Icons.person,
                  color: BottleGreen,
                ),
                activeIcon: Icon(
                  Icons.person,
                  color: BottleGreen,
                ),
                title: Text('Profile'),
              ),
            ],
            opacity: 0.2,
            backgroundColor: White,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            currentIndex: currentIndex,
            onTap: changePage,
            hasInk: true,
            inkColor: Colors.black12,
            hasNotch: true,
            fabLocation: BubbleBottomBarFabLocation.end,
            elevation: 10,
          ),
          body: (currentIndex == 0)
              ? DashBoard(
                  placesProvider: placesProvider,
                  locationProvider: locationProvider,
                )
              : (currentIndex == 1)
                  ? Feed()
                  : Profile()),
    );
  }
}
