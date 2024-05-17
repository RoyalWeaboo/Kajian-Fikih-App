// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/preferences/preferences_utils.dart';
import 'package:kajian_fikih/utils/widgets/bottom_navbar.dart';
import 'package:kajian_fikih/view/jamaah/offline_event/offline_event_detail_screen.dart';
import 'package:kajian_fikih/view/jamaah/profile/edit_profile_screen.dart';
import 'package:kajian_fikih/view/jamaah/profile/history_item.dart';
import 'package:kajian_fikih/view/jamaah/profile/profile_option.dart';
import 'package:kajian_fikih/view/auth/login_screen.dart';
import 'package:kajian_fikih/view/public/saved_post/saved_post_screen.dart';
import 'package:kajian_fikih/view/public/security/change_password_screen.dart';
import 'package:kajian_fikih/viewmodel/history/history_cubit.dart';
import 'package:kajian_fikih/viewmodel/history/history_state.dart';
import 'package:kajian_fikih/viewmodel/profile_jamaah/profile_cubit.dart';
import 'package:kajian_fikih/viewmodel/profile_jamaah/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late PreferencesUtils preferencesUtils;

  @override
  void initState() {
    super.initState();
    initProfileScreen();
  }

  void initProfileScreen() async {
    preferencesUtils = PreferencesUtils();
    await preferencesUtils.init();

    final loginWithGoogle = preferencesUtils.getPreferencesBool("googleLogin");

    context.read<ProfileCubit>().getProfileDetail(loginWithGoogle ?? false);
    context.read<HistoryCubit>().getLatestHistory();
  }

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
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (BuildContext context, ProfileState state) {
          if (state is ProfileErrorState) {
            Navigator.pop(context);
            AnimatedSnackBar.material(
              state.errorMessage,
              type: AnimatedSnackBarType.error,
              snackBarStrategy: RemoveSnackBarStrategy(),
            ).show(context);
          }
          if (state is LogoutErrorState) {
            Navigator.pop(context);
            AnimatedSnackBar.material(
              state.errorMessage,
              type: AnimatedSnackBarType.error,
              snackBarStrategy: RemoveSnackBarStrategy(),
            ).show(context);
          }

          if (state is LogoutSuccessState) {
            Navigator.pushReplacement(
              context,
              SlideLeftAnimation(
                page: const LoginScreen(),
              ),
            );
          }
        },
        builder: (BuildContext context, ProfileState state) {
          if (state is LoadingState) {
            return SizedBox(
                height: height,
                width: width,
                child: const Center(child: CircularProgressIndicator()));
          }
          if (state is ProfileSuccessState) {
            return Container(
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
                            child: state.userDetail.profilePictureUrl != ""
                                ? Image.network(
                                    state.userDetail.profilePictureUrl,
                                  )
                                : Image.asset(
                                    "assets/profile_image_placeholder.jpg",
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
                      state.userDetail.username,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: blackTextColor,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    state.userDetail.location != ""
                        ? Row(
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
                                state.userDetail.location,
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: greyTextColor,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
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
                    BlocBuilder<HistoryCubit, HistoryState>(
                      builder: (context, HistoryState historyState) {
                        if (historyState is HistoryLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (historyState is HistoryErrorState) {
                          return Text(historyState.errorMessage);
                        }
                        if (historyState is HistorySuccessState) {
                          if (historyState.offlineEventHistory.isNotEmpty) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              width: width,
                              height: 240,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 8,
                                ),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:
                                    historyState.offlineEventHistory.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 300,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          SlideLeftAnimation(
                                            page: OfflineEventDetailScreen(
                                                docId: historyState
                                                    .offlineEventHistory[index]
                                                    .docId),
                                          ),
                                        );
                                      },
                                      child: HistoryItem(
                                          backgroundImage: historyState
                                                  .offlineEventHistory[index]
                                                  .imageUrl ??
                                              "",
                                          title: historyState
                                              .offlineEventHistory[index]
                                              .postTitle,
                                          description: historyState
                                              .offlineEventHistory[index]
                                              .postContent),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Text("Tidak ada Riwayat");
                          }
                        } else {
                          return const SizedBox(
                            height: 100,
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          SlideLeftAnimation(
                            page: const SavedPostScreen(),
                          ),
                        );
                      },
                      child: const ProfileItemOption(
                        optionIcon: "assets/saved_icon.png",
                        optionName: "Post Tersimpan",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          SlideLeftAnimation(
                            page: const ChangePasswordScreen(),
                          ),
                        );
                      },
                      child: const ProfileItemOption(
                        optionIcon: "assets/privacy_icon.png",
                        optionName: "Ganti Password",
                      ),
                    ),
                    const ProfileItemOption(
                      optionIcon: "assets/help_icon.png",
                      optionName: "Bantuan",
                    ),
                    InkWell(
                      onTap: () async {
                        await context.read<ProfileCubit>().logout();
                        await preferencesUtils.removePreferences("role");
                      },
                      child: const ProfileItemOption(
                        optionIcon: "assets/logout_icon.png",
                        optionName: "Logout",
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is ProfileErrorState) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const SizedBox();
          }
        },
      ),
      bottomNavigationBar: BottomNavbarComponent(),
    );
  }
}
