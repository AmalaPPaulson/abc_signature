import 'package:abc_signature/model/leadsAndDeals_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomeList extends StatefulWidget {
  const HomeList({super.key, this.results});

  final  List<Result>? results;

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {

  List<String> title = ['Sparrow', 'Elephant', 'Humming Bird', 'Lion'];
  List<String> place = ['annakara','vadakara','thrissur','Ernakulam'];

  @override
  Widget build(BuildContext context) {
    //log('home list result: ${widget.results![0].name}');
    return ListView.builder(
      itemCount: title.length,
      itemBuilder: (BuildContext context, int index) {
        return card( title[index],place[index], context);
      },
    );

  }

  Widget card( String title,String place, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
              Text(title,style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),),
              Text(
                place,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


