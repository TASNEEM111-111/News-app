
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/componanet/componant.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/network/remote/DioHelper.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/search/searchScreen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit,NewsState>(
      listener: (context,states){},
      builder: (context,states){
    var Cubit =cubit.get(context);
    return Scaffold(
    appBar: AppBar(
    title: Text(
      "NEWS APP",
    ),
    actions: [
      IconButton(onPressed: (){
        navigateTo(context, SearchScreen());
      },
          icon: Icon(Icons.search)),

    IconButton(
        onPressed: (){
      cubit.get(context).changeMode();
    },
        icon: Icon(
            Icons.brightness_4_outlined,
        )),

    ],
    ),

    body: Cubit.screens[Cubit.currentIndex],
    bottomNavigationBar: BottomNavigationBar(
    currentIndex: Cubit.currentIndex,
    onTap: (index){
      Cubit.changeBottomNavBar(index);
    },
    items: Cubit.bottomItems,
    ),
    );
    },
    );
  }
}

