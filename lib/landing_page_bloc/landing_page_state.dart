part of 'landing_page_bloc.dart';

@immutable
abstract class LandingPageState {}

class LandingPageInitial extends LandingPageState {}

class LandingPageLoadingST extends LandingPageState {}

class LandingPageLoadedST extends LandingPageState {}

class LandingPageClearST extends LandingPageState {}

class LandingPageFailureST extends LandingPageState {
  final String? errorMsg;

  LandingPageFailureST({required this.errorMsg});
}


class ShopsListST extends LandingPageState {
  final LeAndDealModel? list;

  ShopsListST({
   required this.list,
  });

  
}
class DistNamesST extends LandingPageState{
   final List<DistNameResult>? results;
    DistNamesST({
   required this.results,
  });

    
  }