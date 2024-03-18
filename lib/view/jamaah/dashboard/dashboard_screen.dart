import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/widgets/bottom_navbar.dart';
import 'package:kajian_fikih/view/jamaah/dashboard/category_item.dart';
import 'package:kajian_fikih/view/jamaah/dashboard/notification_screen.dart';
import 'package:kajian_fikih/view/jamaah/offline_event/offline_event_detail_screen.dart';

class JamaahDashboardScreen extends StatefulWidget {
  const JamaahDashboardScreen({super.key});

  @override
  State<JamaahDashboardScreen> createState() => _JamaahDashboardScreenState();
}

class _JamaahDashboardScreenState extends State<JamaahDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
              child: Image.asset('assets/dashboard_background.png'),
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
                    "Jelajahi Kedalaman Ilmu Islam",
                    style: GoogleFonts.outfit(
                      color: secondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Pintumu menuju Pemahaman yang Terang",
                    style: GoogleFonts.outfit(
                      color: whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: height * 0.28,
                    width: width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
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
                              backgroundImage: 'assets/sholat.png',
                              title: 'Sholat',
                              description:
                                  'Lorem ipsum dolor sit amet consectetur.'),
                        ),
                        const DashboardCategoryItem(
                            backgroundImage: 'assets/silaturahmi.png',
                            title: 'Silaturahmi',
                            description:
                                'Lorem ipsum dolor sit amet consectetur.'),
                        const DashboardCategoryItem(
                            backgroundImage: 'assets/quran.png',
                            title: 'Al-Qur\'an',
                            description:
                                'Lorem ipsum dolor sit amet consectetur.'),
                        const DashboardCategoryItem(
                            backgroundImage: 'assets/hadist.png',
                            title: 'Hadist',
                            description:
                                'Lorem ipsum dolor sit amet consectetur.'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Ikuti Kajian Islamic",
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbarComponent(),
    );
  }
}
