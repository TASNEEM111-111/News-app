import 'package:news_app/cubit/states.dart';

abstract class NewsState{}
class initalState extends NewsState{}
class NewsBottomNavState extends NewsState{}
class NewsgetbusinessLoadingState extends NewsState{}
class NewsgetbusinessSucessState extends NewsState{}

class NewsgetbusinessFailedState extends NewsState{
  final String error;
  NewsgetbusinessFailedState(this.error);

}

class NewsgetsportsLoadingState extends NewsState{}
class NewsgetsportsSucessState extends NewsState{}

class NewsgetsportsFailedState extends NewsState{
  final String error;
  NewsgetsportsFailedState(this.error);

}

class NewsgetscienceLoadingState extends NewsState{}
class NewsgetscienceSucessState extends NewsState{}

class NewsgetscienceFailedState extends NewsState {
  final String error;

  NewsgetscienceFailedState(this.error);

}
class appChangeModeState extends NewsState{}

class NewsgetSearchLoadingState extends NewsState{}
class NewsgetSearchSucessState extends NewsState{}

class NewsgetSearchFailedState extends NewsState {
  final String error;

  NewsgetSearchFailedState(this.error);

}