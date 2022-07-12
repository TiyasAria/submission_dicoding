import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reaturant_app/data/api/api_service.dart';
import 'package:reaturant_app/data/db/database_helper.dart';
import 'package:reaturant_app/provider/favorite_provider.dart';
import 'package:reaturant_app/provider/restaurant_provider.dart';
import 'package:reaturant_app/provider/search_provider.dart';
import 'package:reaturant_app/ui/detail_screen.dart';
import 'package:reaturant_app/ui/favorite_screen.dart';
import 'package:reaturant_app/ui/home_screen.dart';
import 'package:reaturant_app/ui/list_restaurant.dart';
import 'package:reaturant_app/ui/search_page.dart';
import 'package:reaturant_app/ui/setting_screen.dart';

import 'ui/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(create: (_) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider(apiService: ApiService())),
        ChangeNotifierProvider<FavoriteProvider>(create: (_) => FavoriteProvider(databaseHelper: DatabaseHelper())),
      ],
      child: MaterialApp(
        title: 'Restaurant App ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          HomeScreen.routeName : (context) => HomeScreen() ,
          FavoriteScreen.routeName : (context) => FavoriteScreen() ,
          SettingScreen.routeName : (context) => SettingScreen() ,
          ListRestaurantScreen.routeName: (context) => ListRestaurantScreen(),
          SearchRestaurantScreen.routeName: (context) => SearchRestaurantScreen(),
          DetailScreen.routeName: (context) =>
              DetailScreen(ModalRoute.of(context)?.settings.arguments as String)
        },
      ),
    );
  }
}
