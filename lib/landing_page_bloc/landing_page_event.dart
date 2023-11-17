part of 'landing_page_bloc.dart';

@immutable
abstract class LandingPageEvent {}

class InitialET extends LandingPageEvent {}

class TabClickET extends LandingPageEvent {
  final String place;
  TabClickET({
    required this.place,
  });
}

class DistSelectET extends LandingPageEvent {}

class LeadsET extends LandingPageEvent{
  final String distName;
  LeadsET({
    required this.distName,
  });
}
class DealersET extends LandingPageEvent{
  final String distName;
  DealersET({
    required this.distName,
  });
}