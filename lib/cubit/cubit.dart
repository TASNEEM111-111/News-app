import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/businessScreen.dart';
import 'package:news_app/modules/scienceScreen.dart';
import 'package:news_app/modules/settingsScreens.dart';
import 'package:news_app/modules/sportsScreen.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/DioHelper.dart';

class cubit extends Cubit <NewsState>{
     cubit():super(initalState());

     static cubit get(context)=> BlocProvider.of(context);
     int currentIndex=0;
     List<BottomNavigationBarItem>bottomItems=[
          BottomNavigationBarItem(
               icon: Icon(Icons.business),
          label: "Business") ,
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_handball_rounded),
                label: "sports") ,
          BottomNavigationBarItem(
              icon: Icon(Icons.science_outlined)
          ,label: "Science") ,
     ];
     List<Widget>screens=[
          businessScreen(),
          sportScreen(),
          scienceScreen(),

     ];
     void changeBottomNavBar(int index){
          currentIndex=index;
          if(index==1){
               getsports();
          }
          else if(index==2){
               getscience();
          }
          emit(NewsBottomNavState());
     }
     List<dynamic>business=[];
     void getBusiness(){
          emit(NewsgetbusinessLoadingState());
          DioHelper.getData(
              url: 'v2/top-headlines',
              query:
              {
                   'country': 'eg',
                   'category': 'business',
                   'apiKey': '233bbe4217be4d06ae5e103fb80f4998',
              }).then((value) {
              // print(value.data['articles'][0]['title']);
               business = value.data['articles'];
             //  print(business.length);
               //print(business[0]['title']);
               emit(NewsgetbusinessSucessState());
          }).catchError((error){
               print(error.toString());
               emit(NewsgetbusinessFailedState(error.toString()));
          });
     }

     List<dynamic>sports=[];
     void getsports(){
          emit(NewsgetsportsLoadingState());
          DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '233bbe4217be4d06ae5e103fb80f4998',
                   }).then((value) {
                    sports=value.data['articles'];
                    //print(sports.length);
                    emit(NewsgetsportsSucessState());
               }).catchError((error){
                    print(error.toString());
                    emit(NewsgetsportsFailedState(error.toString()));
               });
          }


     List<dynamic>science=[];
     void getscience(){
          emit(NewsgetscienceLoadingState());
               DioHelper.getData(
                   url: 'v2/top-headlines',
                   query:{
                        'country':'eg',
                        'category':'science',
                        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
                   }
               ).then((value) {
                    science=value.data['articles'];
                   // print(science.length);
                    emit(NewsgetscienceSucessState());
               }).catchError((error){
                    print(error.toString());
                    emit(NewsgetscienceFailedState(error.toString()));
               });
          }


     bool isDark =false;
     void changeMode({bool? fromShared}){
          if(fromShared!=null){
               isDark=fromShared;
               emit(appChangeModeState());
          }
          else {
               isDark = !isDark;
               CacheHelper.putbool(key: 'isDark', value: isDark).then((value) {
                    emit(appChangeModeState());
               });
          }
     }


     List<dynamic>search=[];
     void getSearch(String value){
          emit(NewsgetSearchLoadingState());
          search=[];
               DioHelper.getData(
                   url: 'v2/everything',
                   query:{
                        'q': value,
                        'apiKey': '233bbe4217be4d06ae5e103fb80f4998',
                   }
               ).then((value) {
                    search=value.data['articles'];
                   // print(search[0]['articles']);
                    //print(search.length);
                    emit(NewsgetSearchSucessState());
               }).catchError((error){
                    print(error.toString());
                    emit(NewsgetSearchFailedState(error.toString()));
               });
          }


}