import 'package:abc_signature/landing_page_bloc/landing_page_bloc.dart';
import 'package:abc_signature/model/distName_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistrictSelect extends StatefulWidget {
  final List<DistNameResult> results;
  const DistrictSelect({super.key, required this.results, });

  @override
  State<DistrictSelect> createState() => _DistrictSelectState();
}

class _DistrictSelectState extends State<DistrictSelect> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Select your District'),
        ListView.builder(
          shrinkWrap: true,
           itemCount: widget.results.length,
            itemBuilder: (BuildContext context, int index) {
             return card( widget.results[index].name, context);
        },
      ),
        ],
      ),
    );
  }
  Widget card( String place, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: (){
          context.read<LandingPageBloc>().add(TabClickET(place: place));
          Navigator.pop(context);
        },
        child: Card(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          elevation: 4.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place,style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
