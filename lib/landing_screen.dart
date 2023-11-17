import 'package:abc_signature/TabTitleTile.dart';
import 'package:abc_signature/district_select.dart';
import 'package:abc_signature/home_list.dart';
import 'package:abc_signature/landing_page_bloc/landing_page_bloc.dart';
import 'package:abc_signature/model/distName_model.dart';
import 'package:abc_signature/sizeconfig.dart';
import 'package:abc_signature/utils/constants/asset_constants.dart';
import 'package:abc_signature/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/leadsAndDeals_model.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int? _currentTab;
  PageController _pageController = PageController();
  final myController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LeAndDealModel? leadsModel;
  LeAndDealModel? dealersModel;
  

  @override
  void initState() {
    context.read<LandingPageBloc>().add(DistSelectET());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState?.openDrawer(),
          /* WScaffold.of(context).openDrawer();rite listener code here */

          child: const Icon(
            Icons.menu,
            color: ColorConstants.whiteColor, // add custom icons also
          ),
        ),
        actions: <Widget>[
          Padding(
              padding:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
              child: BlocBuilder<LandingPageBloc, LandingPageState>(
                buildWhen: (previous, current) => current is DistNamesST,
                builder: (context, state) {
                  List<DistNameResult>? results;
                  String firstPlaceName ='gjjk' ; 
                  if(state is DistNamesST){
                    if(state.results != null && state.results!.isNotEmpty){
                      results = state.results;
                           firstPlaceName = results![0].name;       
                    }
                     
                  }
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  DistrictSelect(results: results!,)));
                      },
                      child:  Row(
                        children: [
                          Text( '$firstPlaceName',
                            style: TextStyle(
                                color: ColorConstants.whiteColor,
                                fontFamily: AssetConstants.oxygenRegular),
                          ),
                          Icon(
                            Icons.expand_more,
                            color: ColorConstants.whiteColor,
                          ),
                        ],
                      ));
                },
              )),
        ],
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(SizeConfig.blockSizeHorizontal * 23),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    SizeConfig.blockSizeHorizontal * 2,
                    SizeConfig.blockSizeHorizontal * 8,
                    SizeConfig.blockSizeHorizontal * 5),
                child: TextField(
                  controller: myController,
                  onChanged: (text) {},
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding:
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                    counterStyle:
                        const TextStyle(color: ColorConstants.lightTextColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 5),
                          topRight: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 5)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(),
                    labelText: '   Please enter your name',
                    labelStyle: TextStyle(
                      color: ColorConstants.lightTextColor,
                      fontSize: SizeConfig.blockSizeHorizontal * 4,
                      //<-- SEE HERE
                    ),
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: createBody(),
      drawer: Drawer(
        backgroundColor: ColorConstants.whiteColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeHorizontal * 2),
                          child: InkWell(
                            child: const Icon(
                              Icons.arrow_back,
                              color: ColorConstants.primaryColor,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 15,
                    ),
                    const Text(
                      'Sajeevan T P',
                      style: TextStyle(
                          fontFamily: AssetConstants.oxygenRegular,
                          color: ColorConstants.textColor),
                    ),
                    const Text(
                      'Marketing Executive',
                      style: TextStyle(
                          fontFamily: AssetConstants.oxygenRegular,
                          color: ColorConstants.textColor),
                    ),
                  ],
                )),
            ListTile(
              leading: const Icon(
                Icons.ac_unit_outlined,
                color: ColorConstants.primaryColor,
              ),
              title: const Text(
                'Catalouge',
                style: TextStyle(
                    fontFamily: AssetConstants.oxygenRegular,
                    color: ColorConstants.textColor),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.ac_unit_outlined,
                color: ColorConstants.primaryColor,
              ),
              title: const Text(
                'About App',
                style: TextStyle(
                    fontFamily: AssetConstants.oxygenRegular,
                    color: ColorConstants.textColor),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.ac_unit_outlined,
                color: ColorConstants.primaryColor,
              ),
              title: const Text(
                'Log out',
                style: TextStyle(
                    fontFamily: AssetConstants.oxygenRegular,
                    color: ColorConstants.textColor),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ), // Populate the Drawer in the next step.
      ),
    );
  }

  //Create Body
  Widget createBody() {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [tabTitle(context), pageView()],
        ),
      ),
    );
  }

  Widget tabTitle(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeHorizontal * 13,
      width: MediaQuery.of(context).size.width,
      color: ColorConstants.whiteColor,
      child: Row(
        children: <Widget>[
          TabTitleTile(
            title: 'Dealers',
            currentTab: _currentTab,
            tabNo: 0,
            color1: (_currentTab == 0)
                ? ColorConstants.primaryColor
                : ColorConstants.whiteColor,
            color2: (_currentTab == 0)
                ? ColorConstants.whiteColor
                : ColorConstants.primaryColor,
            onPressed: () {
              setState(() {
                _currentTab = 0;
              });
              _pageController.animateToPage(_currentTab!,
                  duration: const Duration(milliseconds: 5),
                  curve: Curves.decelerate);
            },
            borderRadiusGeometry: (_currentTab == 0)
                ? const BorderRadius.only(topRight: Radius.circular(5))
                : (_currentTab == 1)
                    ? const BorderRadius.only(bottomRight: Radius.circular(5))
                    : BorderRadius.circular(0),
          ),
          TabTitleTile(
            title: 'Leads',
            tabNo: 1,
            currentTab: _currentTab,
            color1: (_currentTab == 0) || (_currentTab == 2)
                ? ColorConstants.whiteColor
                : ColorConstants.primaryColor,
            color2: (_currentTab == 1)
                ? ColorConstants.whiteColor
                : ColorConstants.primaryColor,
            borderRadiusGeometry: (_currentTab == 0)
                ? const BorderRadius.only(bottomLeft: Radius.circular(8))
                : (_currentTab == 1)
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))
                    : const BorderRadius.only(bottomRight: Radius.circular(8)),
            onPressed: () {
              setState(() {
                _currentTab = 1;
              });
              _pageController.animateToPage(_currentTab!,
                  duration: const Duration(milliseconds: 5),
                  curve: Curves.decelerate);
            },
          ),
        ],
      ),
    );
  }

  Widget pageView() {
    return Expanded(
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentTab = index;
          });
        },
        children: [
          HomeList(),
       
        ],
      ),
    );
  }
}
