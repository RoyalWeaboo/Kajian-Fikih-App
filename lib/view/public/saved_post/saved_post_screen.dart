import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/view/public/explore/explore_item.dart';
import 'package:kajian_fikih/viewmodel/saved_post/saved_post_cubit.dart';
import 'package:kajian_fikih/viewmodel/saved_post/saved_post_state.dart';

class SavedPostScreen extends StatefulWidget {
  const SavedPostScreen({super.key});

  @override
  State<SavedPostScreen> createState() => _SavedPostScreenState();
}

class _SavedPostScreenState extends State<SavedPostScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SavedPostCubit>().getSavedPost();
  }

  void reinitSavedPostPage() {
    context.read<SavedPostCubit>().getSavedPost();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Postingan Tersimpan",
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: blackTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<SavedPostCubit, SavedPostState>(
        builder: (context, state) {
          if (state is SavedPostLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SavedPostSuccessState) {
            return Container(
              width: width,
              height: height,
              color: whiteColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.postResponse.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    if (state.postResponse.isNotEmpty) {
                      return ExploreItem(
                        followedPost: false,
                        postData: state.postResponse[index],
                        onBack: reinitSavedPostPage,
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
            );
          }
          if (state is SavedPostErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
