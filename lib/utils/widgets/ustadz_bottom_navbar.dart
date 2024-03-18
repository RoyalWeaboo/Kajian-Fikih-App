// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/view/jamaah/explore/explore_screen.dart';
import 'package:kajian_fikih/view/jamaah/like/like_screen.dart';
import 'package:kajian_fikih/view/ustadz/dashboard/ustadz_dashboard_screen.dart';
import 'package:kajian_fikih/view/ustadz/profile/ustadz_profile_screen.dart';
import 'package:kajian_fikih/viewmodel/bottom_navbar_provider.dart';
import 'package:provider/provider.dart';

class UstadzBottomNavbarComponent extends StatefulWidget {
  int? indexDefined;
  UstadzBottomNavbarComponent({
    super.key,
    this.indexDefined,
  });

  @override
  State<UstadzBottomNavbarComponent> createState() =>
      _UstadzBottomNavbarComponentState();
}

class _UstadzBottomNavbarComponentState
    extends State<UstadzBottomNavbarComponent> {
  @override
  initState() {
    super.initState();
  }

  void changeScreen(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const UstadzDashboardScreen();
          },
        ), (route) => false);
        break;
      case 1:
        Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const ExploreScreen(
              isUstadz: true,
            );
          },
        ), (route) => false);
        break;
      case 2:
        Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const LikeScreen(
              isUstadz: true,
            );
          },
        ), (route) => false);
        break;
      case 3:
        Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const UstadzProfileScreen();
          },
        ), (route) => false);
        break;

      default:
        Navigator.of(context).pushAndRemoveUntil(
            SlideLeftAnimation(
              page: const UstadzDashboardScreen(),
            ),
            (route) => false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavbarComponentViewModel>(
      builder: (context, model, child) {
        return BottomNavigationBar(
          selectedLabelStyle: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: outlineColor,
          ),
          currentIndex: widget.indexDefined ?? model.currentIndex,
          backgroundColor: whiteColor,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            model.changeIndex(index);
            changeScreen(index);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(
                  top: 8,
                ),
                child: Image(
                  width: 20,
                  height: 20,
                  image: AssetImage("assets/home_on.png"),
                ),
              ),
              icon: Padding(
                padding: EdgeInsets.only(
                  top: 8,
                ),
                child: Image(
                  width: 20,
                  height: 20,
                  image: AssetImage("assets/home_off.png"),
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(
                  top: 8,
                ),
                child: Image(
                  width: 20,
                  height: 20,
                  image: AssetImage("assets/explore_on.png"),
                ),
              ),
              icon: Padding(
                padding: EdgeInsets.only(
                  top: 8,
                ),
                child: Image(
                  width: 20,
                  height: 20,
                  image: AssetImage("assets/explore_off.png"),
                ),
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(
                  top: 8,
                ),
                child: Image(
                  width: 20,
                  height: 20,
                  image: AssetImage("assets/like_on.png"),
                ),
              ),
              icon: Padding(
                padding: EdgeInsets.only(
                  top: 8,
                ),
                child: Image(
                  width: 20,
                  height: 20,
                  image: AssetImage("assets/like_off.png"),
                ),
              ),
              label: 'Like',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(
                  top: 8,
                ),
                child: Image(
                  width: 20,
                  height: 20,
                  image: AssetImage("assets/profile_on.png"),
                ),
              ),
              icon: Padding(
                padding: EdgeInsets.only(
                  top: 8,
                ),
                child: Image(
                  width: 20,
                  height: 20,
                  image: AssetImage("assets/profile_off.png"),
                ),
              ),
              label: 'Profile',
            ),
          ],
          selectedItemColor: primaryColor,
        );
      },
    );
  }
}
