import 'package:abc_signature/sizeconfig.dart';
import 'package:abc_signature/start_page_bloc/start_page_bloc.dart';
import 'package:abc_signature/utils/constants/asset_constants.dart';
import 'package:abc_signature/utils/constants/color_constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'landing_screen.dart';
import 'login_bloc/login_bloc.dart';


class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String? userName;
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<StartPageBloc, StartPageState>(
          listener: (context, state) {
            if (state is StartFailureST) {
              Fluttertoast.showToast(msg: state.errorMsg!);
            }
            if (state is StartSuccessST) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LandingScreen()));
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginSuccessST) {
                    userName = state.name;
                  }
                  return Text('Hi $userName',
                      style: TextStyle(
                          color: ColorConstants.textColor,
                          fontFamily: AssetConstants.oxygenRegular,
                          fontSize: SizeConfig.blockSizeHorizontal * 5));
                },
              ),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal * 4,
              ),
              BlocBuilder<StartPageBloc, StartPageState>(
                buildWhen: (p, c) => c != p ,
                builder: (context, state) {
                  if (state is StartPageLoadingST) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: ()  {
                       initPlatformState().then((value){
                         context.read<StartPageBloc>().add(StartPressET(
                             deviceId: _deviceData['id'],
                             deviceName: _deviceData['model']));
                       });

                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const MyHomePage(
                      //               title: 'ABC signature',
                      //             )),
                      //     (route) => false);
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(color: ColorConstants.primaryColor)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              SizeConfig.blockSizeHorizontal * 1.5))),
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                          ColorConstants.primaryColor),
                      fixedSize: MaterialStatePropertyAll<Size>(
                        Size.fromHeight(SizeConfig.blockSizeHorizontal * 5),
                      ),
                    ),
                    child: Text(
                      'START',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AssetConstants.oxygenRegular,
                          fontSize: SizeConfig.blockSizeHorizontal * 4),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    //var deviceData = <String, dynamic>{};

    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        _deviceData =
            _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        _deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      _deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    if (!mounted) return;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'id': build.id,
      'model': build.model,

    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'id': data.identifierForVendor,
      'model': data.model,
    };
  }


}
