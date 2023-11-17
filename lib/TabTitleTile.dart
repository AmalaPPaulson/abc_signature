import 'package:abc_signature/sizeconfig.dart';
import 'package:abc_signature/utils/constants/asset_constants.dart';
import 'package:abc_signature/utils/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabTitleTile extends StatefulWidget {
  const TabTitleTile({super.key, required this.currentTab,
    required this.onPressed,
    required this.title,
    required this.tabNo,
    required this.borderRadiusGeometry,
    required this.color1,
    required this.color2,});

  final int? currentTab, tabNo;
  final String? title;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final Color? color1, color2;
  final Function()? onPressed;
  @override
  State<TabTitleTile> createState() => _TabTitleTileState();
}

class _TabTitleTileState extends State<TabTitleTile> {
  @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
    return InkWell(
      onTap: () {
        widget.onPressed!();
      },
       child: Container(
         height: SizeConfig.blockSizeHorizontal * 13,
         width: MediaQuery.of(context).size.width / 2,
         decoration: BoxDecoration(color: widget.color1),
         child: Container(
           height: SizeConfig.blockSizeHorizontal * 13,
           width: MediaQuery.of(context).size.width / 2,
           alignment: Alignment.center,
           decoration: BoxDecoration(
               color: widget.color2,
               borderRadius: widget.borderRadiusGeometry),
           child: AnimatedDefaultTextStyle(
             duration: const Duration(milliseconds: 400),
             curve: Curves.easeIn,
             style: (widget.tabNo == widget.currentTab)
                 ? const TextStyle(
                     color: ColorConstants.primaryColor,
                     fontFamily: AssetConstants.oxygenRegular,
                     fontSize: 15)
                 : const TextStyle(
                     color: Colors.white,
                     fontFamily: AssetConstants.oxygenRegular,
                     fontSize: 15),
             child: Text(
               widget.title!,
               /* style: TextStyle(
                 color:  (tabNo == currentTab) ? Constants.primary_color : Colors.grey[700],
                 fontFamily: (tabNo == currentTab) ? Constants.font_name_2 : Constants.font_name_1 ,
                 fontSize: 15
               ),*/
             ),
           ),
         ),
       ),
    );
  }

  // AnimatedOpacity(
          //   opacity: (widget.currentTab == widget.tabNo) ? 1 : 0,
          //   duration: const Duration(milliseconds: 400),
          //   child: AnimatedContainer(
          //     height: SizeConfig.blockSizeHorizontal * 0.7,
          //     duration: const Duration(milliseconds: 400),
          //     curve: Curves.easeIn,
          //     width: (widget.currentTab == widget.tabNo)
          //         ? MediaQuery.of(context).size.width / 3.4
          //         : 0,
          //     color: (widget.currentTab == widget.tabNo)
          //         ? ColorConstants.primaryColor
          //         : Colors.white,
          //   ),
          // ),
}