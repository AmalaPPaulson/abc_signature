import 'package:abc_signature/landing_page_bloc/landing_page_bloc.dart';
import 'package:abc_signature/login_bloc/login_bloc.dart';
import 'package:abc_signature/sizeconfig.dart';
import 'package:abc_signature/start_page_bloc/start_page_bloc.dart';
import 'package:abc_signature/utils/constants/asset_constants.dart';
import 'package:abc_signature/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => StartPageBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => LandingPageBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: ColorConstants.primaryColor),
          useMaterial3: true,
        ),
        home: const MyHomePage(
          title: 'ABC signature',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        title: Text(
          widget.title,
          style: const TextStyle(
              color: ColorConstants.whiteColor,
              fontFamily: AssetConstants.oxygenBold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                    const BorderSide(color: ColorConstants.primaryColor)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        SizeConfig.blockSizeHorizontal * 2))),
                backgroundColor: const MaterialStatePropertyAll<Color>(
                    ColorConstants.primaryColor),
                fixedSize: MaterialStatePropertyAll<Size>(
                  Size.fromHeight(SizeConfig.blockSizeHorizontal * 10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              child: const Text(
                'Start',
                style: TextStyle(
                    color: ColorConstants.whiteColor,
                    fontFamily: AssetConstants.oxygenRegular),
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
