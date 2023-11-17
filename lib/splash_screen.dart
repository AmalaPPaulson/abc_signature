import 'package:abc_signature/sizeconfig.dart';
import 'package:abc_signature/utils/constants/asset_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          height: SizeConfig.blockSizeHorizontal*50,
          width: SizeConfig.blockSizeHorizontal*50,
          image: AssetImage(AssetConstants.appLogo),
        ),
      ),
    ));
  }
}
