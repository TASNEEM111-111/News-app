import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/DioHelper.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'layout/newslayout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getbool(key: 'isDark');
  runApp(MyApp(isDark ?? false)); // Use a default value (false) if isDark is null
}


class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider(create: (context)=>cubit()..changeMode(fromShared: isDark,)..getBusiness()),
      //  BlocProvider(create: (context)=> cubit(),),
      ],
      child: BlocConsumer <cubit, NewsState>(
        listener: (context,index){},
        builder: (context,index){
          return MaterialApp
            (
            debugShowCheckedModeBanner: false,
            theme:ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                titleSpacing: 20,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarBrightness: Brightness.dark,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
                elevation: 30,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              textTheme: TextTheme(
                bodyText1:TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                titleSpacing: 20,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarBrightness: Brightness.light,
                ),
                iconTheme: IconThemeData(
                  color:Colors.white,
                ),
                backgroundColor:HexColor('333739'),
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textTheme: TextTheme(
                  bodyText1:TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 30,
                backgroundColor: HexColor('333739'),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              textTheme: TextTheme(
                bodyText1:TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: cubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            home :NewsLayout(),
          );
        },
      ),
    );
  }
}



