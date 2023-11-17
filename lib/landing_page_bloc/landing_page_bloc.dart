import 'dart:developer';

import 'package:abc_signature/repositories/landing_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../model/distName_model.dart';
import '../model/leadsAndDeals_model.dart';

part 'landing_page_event.dart';
part 'landing_page_state.dart';

class LandingPageBloc extends Bloc<LandingPageEvent, LandingPageState> {
  LandingRepository landingRepository = LandingRepository();
  LandingPageBloc() : super(LandingPageInitial()) {
    on<DistSelectET>((event, emit)async  {
      emit(LandingPageLoadingST());
      try {
        Response? response = await landingRepository.distName();
        if (response!.statusCode == 200) {
          DistName distName = DistName.fromJson(response.data);
          log('DistName response ${response.data}');
          log('first district ${distName.results[0].name}');
          log(' dist response statusmessage ${response.statusMessage}');
          log('dist response statuCode ${response.statusCode}');
          String firstDistName = distName.results[0].name;
          emit(DistNamesST(results:distName.results));
          add(TabClickET(place: firstDistName));

        } else {
          log('dist response ${response.statusCode}');
          log('dist response ${response.data}');
          log(' dist response status message ${response.statusMessage}');
          emit(LandingPageFailureST(errorMsg: 'distname'));
        }
      } catch (e) {
        emit(LandingPageFailureST(errorMsg: e.toString()));
      }
      emit(LandingPageLoadedST());
    });

      on<TabClickET>((event, emit)async {
     emit(LandingPageLoadingST());
     //get dealers shop list
     LeAndDealModel? dealers;
     LeAndDealModel? leads;
        
        Response? response = await landingRepository.getDealersList(event.place);
        if (response!.statusCode == 200) {
          dealers = LeAndDealModel.fromJson(response.data);
          log('dealers response ${response.statusCode}');
          log('dealers response status message ${response.statusMessage}');
          log('dealers response ${response.data}');
          log('first Dealer: ${dealers.results![0].name}');
        } else {
          log('dealers response ${response.statusCode}');
          log('dealers response ${response.data}');
          log('dealers response status message ${response.statusMessage}');
          emit(LandingPageFailureST(errorMsg: 'distname'));
        }
         Response? leadResponse =await landingRepository.getLeadsList(event.place);
        
            if (leadResponse!.statusCode == 200) { 
           leads = LeAndDealModel.fromJson(leadResponse.data);
          log('leads  response ${leadResponse.statusCode}');
          log('leads  response status message ${leadResponse.statusMessage}');
          log('leads  response ${leadResponse.data}');
          log('first leads shop : ${leads .results![0].name}');
        } else {
          log('leads  response ${leadResponse.statusCode}');
          log('leads  response ${leadResponse.data}');
          log('leads  response status message ${leadResponse.statusMessage}');
          emit(LandingPageFailureST(errorMsg: 'distname'));
        }
        try {
      } catch (e) {
        emit(LandingPageFailureST(errorMsg: e.toString()));
        log('gfjhvjvkjbjkbglhnchl--------------------${e.toString()}');
      }
      //get leads shop list
      
      emit(LandingPageLoadedST());

        int currentIndex =0;

        if(currentIndex ==0 ){
          log('dealer------------- ${dealers?.results![0].name}}');
          emit(ShopsListST(list: dealers));
        }else{
          emit(ShopsListST(list: leads));
        }


    });
   
 



  }

}
