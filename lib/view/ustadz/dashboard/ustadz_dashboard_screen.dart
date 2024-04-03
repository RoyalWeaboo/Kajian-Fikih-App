import 'package:calendar_slider/calendar_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/widgets/ustadz_bottom_navbar.dart';
import 'package:kajian_fikih/view/jamaah/dashboard/category_item.dart';
import 'package:kajian_fikih/view/jamaah/dashboard/notification_screen.dart';
import 'package:kajian_fikih/view/jamaah/offline_event/offline_event_detail_screen.dart';
import 'package:kajian_fikih/view/ustadz/post/create_post_screen.dart';

class UstadzDashboardScreen extends StatefulWidget {
  const UstadzDashboardScreen({super.key});

  @override
  State<UstadzDashboardScreen> createState() => _UstadzDashboardScreenState();
}

class _UstadzDashboardScreenState extends State<UstadzDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 16,
          ),
          child: Image.asset(
            "assets/main_logo_white.png",
            width: 24,
          ),
        ),
        title: Text(
          "Kajian Fikih",
          style: GoogleFonts.outfit(
            color: whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  SlideLeftAnimation(
                    page: const NotificationScreen(),
                  ),
                );
              },
              child: Image.asset(
                'assets/notifications.png',
                width: 24,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                'assets/dashboard_background.png',
                width: width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selamat Datang, Ust. Tomy",
                    style: GoogleFonts.outfit(
                      color: secondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Sampaikan yang harus disampaikan.",
                    style: GoogleFonts.outfit(
                      color: whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Material(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kalender",
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              color: blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          CalendarSlider(
                            fullCalendar: false,
                            monthYearButtonBackgroundColor: Colors.transparent,
                            monthYearTextColor: blackColor,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 4)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 4)),
                            selectedTileBackgroundColor: secondaryColor,
                            tileBackgroundColor: primaryColor,
                            dateColor: whiteColor,
                            onDateSelected: (date) {
                              //do nothing
                            },
                          ),
                          Text(
                            "Pengajian Offline",
                            style: GoogleFonts.outfit(
                              color: blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "08.00 - 11.00 WIB 19 Januari 2024",
                            style: GoogleFonts.inter(
                              color: blackColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "“Siasat menunaikan Ibadah dalam keadaan tidak memungkinkan untuk mendapatkan keridhoan Allah”.",
                            style: GoogleFonts.outfit(
                              color: blackColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Kajian Terakhir Anda",
                    style: GoogleFonts.outfit(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Tab bar added later",
                    style: GoogleFonts.outfit(
                      color: blackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width,
                    child: StaggeredGrid.count(
                      crossAxisSpacing: 8,
                      crossAxisCount: 2,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              SlideLeftAnimation(
                                page: const OfflineEventDetailScreen(),
                              ),
                            );
                          },
                          child: const DashboardCategoryItem(
                              backgroundImage: 'assets/grid_1.png',
                              title: 'Sholat',
                              description:
                                  'Lorem ipsum dolor sit amet consectetur. Commodo elementum in orci semper mi a quam. Eleifend egestas porta molestie velit ut maecenas posuere.'),
                        ),
                        const DashboardCategoryItem(
                            backgroundImage: 'assets/grid_2.png',
                            title: 'Sholat',
                            description:
                                'Lorem ipsum dolor sit amet consectetur. Commodo elementum in orci semper mi a quam. Eleifend egestas porta molestie velit ut maecenas posuere.'),
                        const DashboardCategoryItem(
                            backgroundImage: 'assets/grid_3.png',
                            title: 'Sholat',
                            description:
                                'Lorem ipsum dolor sit amet consectetur. Commodo elementum in orci semper mi a quam. Eleifend egestas porta molestie velit ut maecenas posuere.'),
                        const DashboardCategoryItem(
                            backgroundImage: 'assets/grid_4.png',
                            title: 'Sholat',
                            description:
                                'Lorem ipsum dolor sit amet consectetur. Commodo elementum in orci semper mi a quam. Eleifend egestas porta molestie velit ut maecenas posuere.'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: UstadzBottomNavbarComponent(),
    );
  }
}
