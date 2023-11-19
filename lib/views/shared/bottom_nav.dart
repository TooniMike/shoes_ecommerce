import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/mainscreen_provider.dart';
import 'shared.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child){
        return SafeArea(
      child: Padding(padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BotomNavWidget(
                onTap: (){
                mainScreenNotifier.pageIndex = 0;
              }, 
              icon: mainScreenNotifier.pageIndex == 0 
              ? MaterialCommunityIcons.home 
              : MaterialCommunityIcons.home_outline),
              BotomNavWidget(
                onTap: (){
                mainScreenNotifier.pageIndex = 1;
              }, icon: mainScreenNotifier.pageIndex == 1 ? Ionicons.search 
              : Ionicons.search_outline,
              ),
              BotomNavWidget(
                onTap: (){
                mainScreenNotifier.pageIndex = 2;
              }, icon: mainScreenNotifier.pageIndex == 2 
              ? Ionicons.heart
              : Ionicons.heart_circle_outline,
              ),
              
              BotomNavWidget(
                onTap: (){
                mainScreenNotifier.pageIndex = 3;
              }, icon: mainScreenNotifier.pageIndex == 3 ? Ionicons.person
              : Ionicons.person_outline
              ),
            ]
            ),
      ),
      )
      );
      }
      );
  }
}