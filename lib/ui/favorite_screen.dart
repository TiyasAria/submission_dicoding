import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reaturant_app/data/model/enum_state.dart';
import 'package:reaturant_app/provider/favorite_provider.dart';
import 'package:reaturant_app/widget/list_restaurant.dart';

import '../theme.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  static const routeName = '/favScreen' ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Favorite Restaurant', style: commonText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 28),
              ) ,
              const SizedBox(height: 10,),
              Flexible(
                child: Consumer<FavoriteProvider?>(
                    builder: (context , data , _){
                      if (data?.state == ResultState.hasData){
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data?.favorite.length,
                            itemBuilder: (context , index){
                                return buildRestaurantItem(context, data!.favorite[index]);
                            }
                        );
                      } else if (data?.state == ResultState.error){
                        return Center(
                          child:  Text(data!.message),
                        );
                      } else if (data?.state == ResultState.noData){
                        return Center(
                          child: Column(
                            children: [
                              Icon(Icons.hourglass_empty, size: 30,),
                              SizedBox(height: 10,),
                              Text(data!.message)
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(''),
                        ) ;
                      }
                    }
                ),
              )
            ],
          )
      ),
    );
  }
}
