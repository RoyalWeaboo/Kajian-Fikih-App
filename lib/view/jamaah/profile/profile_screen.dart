import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/widgets/bottom_navbar.dart';
import 'package:kajian_fikih/view/jamaah/dashboard/category_item.dart';
import 'package:kajian_fikih/view/jamaah/profile/edit_profile_screen.dart';
import 'package:kajian_fikih/view/jamaah/profile/profile_option.dart';
import 'package:kajian_fikih/view/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            kToolbarHeight +
            kBottomNavigationBarHeight);
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
      ),
      body: Container(
        height: height,
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
                      page: const EditProfileScreen(),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Kajian Terakhir",
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: blackTextColor,
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: 200,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: const [
                    DashboardCategoryItem(
                        backgroundImage: 'assets/sholat.png',
                        title: 'Sholat',
                        description: 'Lorem ipsum dolor sit amet consectetur.'),
                    DashboardCategoryItem(
                        backgroundImage: 'assets/silaturahmi.png',
                        title: 'Silaturahmi',
                        description: 'Lorem ipsum dolor sit amet consectetur.'),
                    DashboardCategoryItem(
                        backgroundImage: 'assets/quran.png',
                        title: 'Al-Qur\'an',
                        description: 'Lorem ipsum dolor sit amet consectetur.'),
                    DashboardCategoryItem(
                        backgroundImage: 'assets/hadist.png',
                        title: 'Hadist',
                        description: 'Lorem ipsum dolor sit amet consectetur.'),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const ProfileItemOption(
                optionIcon: "assets/saved_icon.png",
                optionName: "Kajian Tersimpan",
              ),
              const ProfileItemOption(
                optionIcon: "assets/privacy_icon.png",
                optionName: "Kebijakan Privasi",
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
        ),
      ),
      bottomNavigationBar: BottomNavbarComponent(),
    );
  }
}
