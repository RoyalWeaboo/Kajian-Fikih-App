import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/model/dummy_post.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/widgets/bottom_navbar.dart';
import 'package:kajian_fikih/utils/widgets/triangle_tab_indicator.dart';
import 'package:kajian_fikih/utils/widgets/ustadz_bottom_navbar.dart';
import 'package:kajian_fikih/view/jamaah/explore/explore_item.dart';
import 'package:kajian_fikih/view/ustadz/post/create_post_screen.dart';

class ExploreScreen extends StatefulWidget {
  final bool? isUstadz;
  const ExploreScreen({super.key, this.isUstadz});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            kToolbarHeight +
            kBottomNavigationBarHeight);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              alignment: Alignment.center,
              child: TabBar(
                indicator: TriangleTabIndicator(color: Colors.white),
                labelColor: secondaryColor,
                unselectedLabelColor: whiteTextColor,
                tabs: [
                  Tab(
                    child: Text(
                      "Untuk Anda",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Mengikuti",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          width: width,
          height: height,
          color: whiteColor,
          child: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: ExploreItem(postingan: dummyTestPost),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: ExploreItem(postingan: []),
              )
            ],
          ),
        ),
        floatingActionButton: widget.isUstadz ?? false
            ? Container(
                decoration: const BoxDecoration(
                  color: secondaryColor,
                  shape: BoxShape.circle,
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      SlideLeftAnimation(
                        page: const CreatePostScreen(),
                      ),
                    );
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Text(
                    "+",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: whiteColor,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: widget.isUstadz ?? false
            ? UstadzBottomNavbarComponent()
            : BottomNavbarComponent(),
      ),
    );
  }
}
