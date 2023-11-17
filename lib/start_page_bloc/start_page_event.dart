part of 'start_page_bloc.dart';

@immutable
abstract class StartPageEvent {}

class StartPressET extends StartPageEvent{
  final String? deviceName;
  final String? deviceId;

  StartPressET({
    required this.deviceName,
    required this.deviceId,
  });
}
