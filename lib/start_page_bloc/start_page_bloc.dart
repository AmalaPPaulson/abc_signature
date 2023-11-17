import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../repositories/user_repo.dart';

part 'start_page_event.dart';
part 'start_page_state.dart';

class StartPageBloc extends Bloc<StartPageEvent, StartPageState> {
  UserRepository userRepository = UserRepository();
  StartPageBloc() : super(StartPageInitial()) {
    on<StartPressET>((event, emit) async {
      String datetime = DateTime.now().toString();
      Position? position;
      /// Determine the current position of the device.
      /// When the location services are not enabled or permissions
      /// are denied the `Future` will return an error.
        bool serviceEnabled;
        LocationPermission permission;

        // Test if location services are enabled.
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          // Location services are not enabled don't continue
          // accessing the position and request users of the
          // App to enable the location services.
          return Future.error('Location services are disabled.');
        }

        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            // Permissions are denied, next time you could try
            // requesting permissions again (this is also where
            // Android's shouldShowRequestPermissionRationale
            // returned true. According to Android guidelines
            // your App should show an explanatory UI now.
            return Future.error('Location permissions are denied');
          }
        }

        if (permission == LocationPermission.deniedForever) {
          // Permissions are denied forever, handle appropriately.
          return Future.error(
              'Location permissions are permanently denied, we cannot request permissions.');
        }

        // When we reach here, permissions are granted and we can
        // continue accessing the position of the device.
        position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        //return position;
       String loc = "SRID=4326;POINT (${position.latitude.toString()} ${position.longitude.toString()})" ;

      emit(StartPageLoadingST());
      try {
        Response? response = await userRepository.checkInTodayDetails(datetime,loc,event.deviceId!,event.deviceName!);
        if(response!.statusCode == 201){
          log('Response status code : ${response.statusCode.toString()}');
          log('Response status message : ${response.statusMessage.toString()}');
          log('Response data : ${response.data.toString()}');
          await userRepository.storeCheckInDate(datetime);
          emit(ClearST());
          emit(StartSuccessST(checkInDate: datetime));
        }
        else {
          log('Response status code : ${response.statusCode.toString()}');
          log('Response status message : ${response.statusMessage.toString()}');
          log('Response data : ${response.data.toString()}');
          emit(StartFailureST(errorMsg: 'Unable to log in with provided credentials.'));

        }
      } catch(e){
        emit(StartFailureST(errorMsg: e.toString()));
      }


    });
  }

}
