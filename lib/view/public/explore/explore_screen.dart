import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/widgets/bottom_navbar.dart';
import 'package:kajian_fikih/utils/widgets/triangle_tab_indicator.dart';
import 'package:kajian_fikih/utils/widgets/ustadz_bottom_navbar.dart';
import 'package:kajian_fikih/view/public/explore/explore_item.dart';
import 'package:kajian_fikih/view/ustadz/post/create_post_screen.dart';
import 'package:kajian_fikih/viewmodel/post/post_cubit.dart';
import 'package:kajian_fikih/viewmodel/post/post_state.dart';

class ExploreScreen extends StatefulWidget {
  final bool? isUstadz;
  const ExploreScreen({super.key, this.isUstadz});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().getAllPost();
  }

  void reinitExplorePage() {
    context.read<PostCubit>().getAllPost();
  }

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
        body: BlocConsumer<PostCubit, PostState>(
          listener: (context, state) {
            if (state is PostErrorState) {
              AnimatedSnackBar.material(
                state.errorMessage,
                type: AnimatedSnackBarType.error,
                snackBarStrategy: RemoveSnackBarStrategy(),
              ).show(context);
            }
          },
          builder: (context, state) {
            if (state is PostLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PostSuccessState) {
              return Container(
                width: width,
                height: height,
                color: whiteColor,
                child: TabBarView(
                  children: [
                    Padding(
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
                          if (state.postResponse.isNotEmpty) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ExploreItem(
                                  followedPost: false,
                                  postData: state.postResponse[index],
                                  onBack: reinitExplorePage,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            );
                          } else {
                            return SizedBox(
                              height: height,
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
                        },
                      ),
                    ),
                    Padding(
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
                          if (state.followedUserPostResponse.isNotEmpty) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ExploreItem(
                                  followedPost: false,
                                  postData:
                                      state.followedUserPostResponse[index],
                                  onBack: reinitExplorePage,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            );
                          } else {
                            return SizedBox(
                              height: height,
                              child: Center(
                                child: Text(
                                  "Anda belum mengikuti siapapun",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is PostErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else {
              return const SizedBox();
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
      ),
    );
  }
}
