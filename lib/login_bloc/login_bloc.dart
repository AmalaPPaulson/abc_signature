import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../model/login_model.dart';
import '../repositories/user_repo.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository = UserRepository();
  LoginBloc() : super(LoginInitial()) {

    on<LoginPressET>((event,emit) async {
      if(event.password == null || event.password!.isEmpty) {
        emit(LoginFailureST(errorMsg: 'Please enter Password'));
      }else if(event.userId == null || event.userId!.isEmpty){
        emit(LoginFailureST(errorMsg: 'Please enter UserID'));
      }
      else if (event.userId!.length < 10){
        emit(LoginFailureST(errorMsg: 'UserId Should be 10 digits'));
      }  else {
        emit(LoadingST());
        try {
          Response? response = await userRepository.login(event.password!,event.userId!);
          if(response!.statusCode == 200){
            LoginModel loginModel = LoginModel.fromJson(response.data);
            log('login response ${response.data}');
            await userRepository.setIsLogged(true);
              await    userRepository.storeUserDetails(loginModel);
            LoginModel? loginModelLocal = await userRepository.getUserDetail();
            String username = '${loginModelLocal!.firstName.toString()}  ${loginModelLocal.lastName.toString()}';

            emit(ClearST());
            emit(LoginSuccessST(name: username));
        }
          else if(response.statusCode == 400){
            emit(LoginFailureST(errorMsg: 'Unable to log in with provided credentials.'));

          }
      } catch(e){
          emit(LoginFailureST(errorMsg: e.toString()));
        }
        }

    });
  }
}


