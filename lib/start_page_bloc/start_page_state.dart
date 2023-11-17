part of 'start_page_bloc.dart';

@immutable
abstract class StartPageState {}

class StartPageInitial extends StartPageState {}

class StartPageLoadingST extends StartPageState {}

class LoadedST extends StartPageState {}

class StartSuccessST extends StartPageState {
   final String? checkInDate;
   StartSuccessST({required this.checkInDate});

}

class StartFailureST extends StartPageState {
  final String? errorMsg;

  StartFailureST({required this.errorMsg});
}

class ClearST extends StartPageState {}

