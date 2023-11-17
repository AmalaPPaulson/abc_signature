import 'package:abc_signature/login_bloc/login_bloc.dart';
import 'package:abc_signature/sizeconfig.dart';
import 'package:abc_signature/start_screen.dart';
import 'package:abc_signature/utils/constants/asset_constants.dart';
import 'package:abc_signature/utils/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? userId;
  String? password;
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 7),
            child: Center(
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if(state is LoginFailureST){
                    Fluttertoast.showToast(msg: state.errorMsg!);
                  }
                  if (state is LoginSuccessST) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StartScreen()));
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetConstants.shopperLogo,
                      height: SizeConfig.blockSizeHorizontal * 80,
                      width: SizeConfig.blockSizeHorizontal * 65,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 10),
                      child: TextField(
                        controller: userIdController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (text) {
                          userId = userIdController.text;
                        },
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.all(
                              SizeConfig.blockSizeHorizontal * 3),
                          counterStyle: const TextStyle(
                              color: ColorConstants.lightTextColor),
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: ColorConstants.textFieldBorder,
                          )),
                          labelText: 'UserID',
                          labelStyle: const TextStyle(
                            color: ColorConstants.greyColor,
                            fontFamily: AssetConstants.oxygenBold,
                            fontSize: 14,
                            //<-- SEE HERE
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 10),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        onChanged: (text) {
                          password = passwordController.text;
                        },
                        decoration: InputDecoration(
                          counterStyle: const TextStyle(
                              color: ColorConstants.lightTextColor),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.all(
                              SizeConfig.blockSizeHorizontal * 3),
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: ColorConstants.textFieldBorder,
                          )),
                          labelText: 'Pin',
                          labelStyle: const TextStyle(
                            color: ColorConstants.greyColor,
                            fontFamily: AssetConstants.oxygenBold,
                            fontSize: 14,
                            //<-- SEE HERE
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 5,
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (p, c) => c != p ,
                      builder: (context, state) {
                        if (state is LoadingST) {
                          return const CircularProgressIndicator();
                        }
                        return ElevatedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(
                                color: ColorConstants.primaryColor)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.blockSizeHorizontal * 1.5))),
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    ColorConstants.primaryColor),
                            fixedSize: MaterialStatePropertyAll<Size>(
                              Size.fromHeight(
                                  SizeConfig.blockSizeHorizontal * 5),
                            ),
                          ),
                          onPressed: () {
                            context.read<LoginBloc>().add(LoginPressET(
                                password: password, userId: userId));
                          },
                          child: Text(
                            'Login',
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
          ),
        ),
      ),
    );
  }
}
