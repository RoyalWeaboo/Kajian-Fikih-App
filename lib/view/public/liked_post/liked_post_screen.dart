import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/widgets/bottom_navbar.dart';
import 'package:kajian_fikih/utils/widgets/ustadz_bottom_navbar.dart';
import 'package:kajian_fikih/view/public/explore/explore_item.dart';
import 'package:kajian_fikih/view/ustadz/post/create_post_screen.dart';
import 'package:kajian_fikih/viewmodel/liked_post/liked_post_cubit.dart';
import 'package:kajian_fikih/viewmodel/liked_post/liked_post_state.dart';

class LikeScreen extends StatefulWidget {
  final bool? isUstadz;
  const LikeScreen({super.key, this.isUstadz});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LikedPostCubit>().getLikedPost();
  }

  void reinitLikePage() {
    context.read<LikedPostCubit>().getLikedPost();
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
        backgroundColor: primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Liked Post",
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: whiteTextColor,
          ),
        ),
      ),
      body: BlocBuilder<LikedPostCubit, LikedPostState>(
        builder: (BuildContext context, LikedPostState state) {
          if (state is LikedPostErrorState) {
            return SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Text(
                  "Error : ${state.errorMessage}",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                ),
              ),
            );
          }
          if (state is LikedPostLoadingState) {
            return SizedBox(
              height: height,
              width: width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is LikedPostSuccessState) {
            if (state.postResponse.isNotEmpty) {
              return Container(
                height: height,
                width: width,
                color: whiteColor,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 24,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.postResponse.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      return ExploreItem(
                        followedPost: false,
                        postData: state.postResponse[index],
                        onBack: reinitLikePage,
                      );
                    },
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: height - 32,
                width: width,
                child: Center(
                  child: Text(
                    "Tidak ada postingan",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: blackColor,
                    ),
                  ),
                ),
              );
            }
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
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
    );
  }
}
