// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/preferences/preferences_utils.dart';
import 'package:kajian_fikih/view/jamaah/dashboard/category_item.dart';
import 'package:kajian_fikih/view/jamaah/offline_event/offline_event_detail_screen.dart';
import 'package:kajian_fikih/view/auth/login_screen.dart';
import 'package:kajian_fikih/viewmodel/follow_user/follow_cubit.dart';
import 'package:kajian_fikih/viewmodel/follow_user/follow_state.dart';
import 'package:kajian_fikih/viewmodel/profile_ustadz/profile_ustadz_cubit.dart';
import 'package:kajian_fikih/viewmodel/profile_ustadz/profile_ustadz_state.dart';

class PublicUstadzProfileScreen extends StatefulWidget {
  final String uid;
  final VoidCallback onBack;

  const PublicUstadzProfileScreen({
    super.key,
    required this.uid,
    required this.onBack,
  });

  @override
  State<PublicUstadzProfileScreen> createState() =>
      _PublicUstadzProfileScreenState();
}

class _PublicUstadzProfileScreenState extends State<PublicUstadzProfileScreen> {
  late PreferencesUtils preferencesUtils;

  @override
  void initState() {
    super.initState();
    initPreferences();
    context.read<ProfileUstadzCubit>().getProfileDetailByUserId(widget.uid);
  }

  Future initPreferences() async {
    preferencesUtils = PreferencesUtils();
    await preferencesUtils.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
            widget.onBack();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            padding: const EdgeInsets.symmetric(),
            child: Image.asset(
              "assets/arrow_back.png",
            ),
          ),
        ),
        leadingWidth: 32,
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
        width: width,
        height: height,
        color: whiteColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: BlocConsumer<ProfileUstadzCubit, ProfileUstadzState>(
          listener:
              (BuildContext context, ProfileUstadzState profileUstadzState) {
            if (profileUstadzState is ProfileUstadzLogoutSuccessState) {
              Navigator.pop(context);
              preferencesUtils.removePreferences("role");
              Navigator.pushReplacement(
                context,
                SlideLeftAnimation(
                  page: const LoginScreen(),
                ),
              );
            }
            if (profileUstadzState is ProfileUstadzLogoutErrorState) {
              AnimatedSnackBar.material(
                profileUstadzState.errorMessage,
                type: AnimatedSnackBarType.error,
                snackBarStrategy: RemoveSnackBarStrategy(),
              ).show(context);
            }
            if (profileUstadzState is ProfileUstadzErrorState) {
              AnimatedSnackBar.material(
                profileUstadzState.errorMessage,
                type: AnimatedSnackBarType.error,
                snackBarStrategy: RemoveSnackBarStrategy(),
              ).show(context);
            }
            if (profileUstadzState is ProfileUstadzSuccessState) {
              context.read<FollowCubit>().getFollowStatus(widget.uid);
            }
          },
          builder: (context, state) {
            if (state is ProfileUstadzLoadingState) {
              return SizedBox(
                height: height,
                width: width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is ProfileUstadzSuccessState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 22,
                          child: state.userDetail.profilePictureUrl != ""
                              ? SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(
                                      state.userDetail.profilePictureUrl,
                                    ),
                                  ),
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
                      ],
                    ),
                    Text(
                      "Ust. ${state.userDetail.username}",
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
                          state.userDetail.location,
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
                    BlocBuilder<FollowCubit, FollowState>(
                      builder: (BuildContext context, FollowState followState) {
                        if (followState is FollowLoadingState) {
                          return const CircularProgressIndicator();
                        }
                        if (followState is FollowErrorState) {
                          return Text(followState.errorMessage);
                        }
                        if (followState is GetFollowStatusSuccessState) {
                          return Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: followState.isFollowed
                                      ? greyBackgroundColor
                                      : primaryColor,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: const Size(0, 0),
                                ),
                                onPressed: () {
                                  context
                                      .read<FollowCubit>()
                                      .followUser(widget.uid);
                                  context
                                      .read<FollowCubit>()
                                      .getFollowStatus(widget.uid);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: followState.isFollowed
                                      ? Text(
                                          "Diikuti",
                                          style: GoogleFonts.outfit(
                                            fontSize: 12,
                                            color: blackGreyTextColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      : Text(
                                          "+ Ikuti",
                                          style: GoogleFonts.outfit(
                                            fontSize: 12,
                                            color: whiteTextColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
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
                                  (state.ustadzProfileDetail?.kajianCount ?? 0)
                                      .toString(),
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
                                  (state.ustadzProfileDetail?.followerCount ??
                                          0)
                                      .toString(),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.userDetail.description ?? "",
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: blackTextColor,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Kajian",
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: blackTextColor,
                        ),
                      ),
                    ),
                    (state.ustadzProfileDetail?.offlineEvents ?? []).isNotEmpty
                        ? Container(
                            alignment: Alignment.center,
                            width: width,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 224,
                              ),
                              shrinkWrap: true,
                              itemCount:
                                  (state.ustadzProfileDetail?.offlineEvents ??
                                          [])
                                      .length,
                              itemBuilder: (context, index) {
                                final listData = state
                                    .ustadzProfileDetail!.offlineEvents![index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      SlideLeftAnimation(
                                        page: OfflineEventDetailScreen(
                                          docId: state.ustadzProfileDetail!
                                              .offlineEvents![index].docId,
                                        ),
                                      ),
                                    );
                                  },
                                  child: DashboardCategoryItem(
                                    backgroundImage: listData.imageUrl!,
                                    title: listData.postTitle,
                                    description: listData.postContent,
                                    isAssetImage: false,
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            color: whiteColor,
                            height: 300,
                            child: Center(
                              child: Text(
                                "Belum ada Kajian",
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: blackTextColor,
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                color: whiteColor,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
