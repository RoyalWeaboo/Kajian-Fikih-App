import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/widgets/ustadz_bottom_navbar.dart';
import 'package:kajian_fikih/view/jamaah/dashboard/category_item.dart';
import 'package:kajian_fikih/view/jamaah/offline_event/offline_event_detail_screen.dart';
import 'package:kajian_fikih/view/jamaah/profile/profile_option.dart';
import 'package:kajian_fikih/view/login_screen.dart';
import 'package:kajian_fikih/view/ustadz/post/create_post_screen.dart';
import 'package:kajian_fikih/view/ustadz/profile/ustadz_edit_profile_screen.dart';

class UstadzProfileScreen extends StatefulWidget {
  const UstadzProfileScreen({super.key});

  @override
  State<UstadzProfileScreen> createState() => _UstadzProfileScreenState();
}

class _UstadzProfileScreenState extends State<UstadzProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profil",
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: blackColor,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    width: width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/main_logo.png",
                          width: 64,
                          fit: BoxFit.fitWidth,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        InkWell(
                          onTap: () {
                            //close bottomsheet first
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              SlideLeftAnimation(
                                page: const UstadzEditProfileScreen(),
                              ),
                            );
                          },
                          child: const ProfileItemOption(
                            optionIcon: "assets/privacy_icon.png",
                            optionName: "Edit Profil",
                          ),
                        ),
                        const ProfileItemOption(
                          optionIcon: "assets/help_icon.png",
                          optionName: "Bantuan",
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              SlideLeftAnimation(
                                page: const LoginScreen(),
                              ),
                            );
                          },
                          child: const ProfileItemOption(
                            optionIcon: "assets/logout_icon.png",
                            optionName: "Logout",
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: const Icon(
              Icons.settings,
            ),
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
      body: Container(
        width: width,
        color: whiteColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    SlideLeftAnimation(
                      page: const UstadzEditProfileScreen(),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 22,
                      child: Image.asset(
                        "assets/profile_placeholder.png",
                        width: 100,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Image.asset(
                      "assets/profile_decoration.png",
                      width: 130,
                      fit: BoxFit.fitWidth,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 24,
                      child: Image.asset(
                        "assets/edit_profile_icon.png",
                        width: 32,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "John Doe",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: blackTextColor,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/location_icon.png",
                    width: 16,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Location",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: greyTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: greyOutlineColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "20",
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Kajian",
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: blackTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: greyOutlineColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "1045",
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Pengikut",
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: blackTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Lorem ipsum dolor sit amet consectetur. Adipiscing eleifend interdum malesuada egestas ut in et enim viverra. Lacus facilisis blandit mauris egestas eget est nulla dis sagittis. Tincidunt scelerisque iaculis lectus dui odio. Turpis venenatis est iaculis iaculis vitae malesuada augue donec at. Eget sit natoque etiam purus.",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: blackTextColor,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Kajian Anda",
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: blackTextColor,
                  ),
                ),
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
