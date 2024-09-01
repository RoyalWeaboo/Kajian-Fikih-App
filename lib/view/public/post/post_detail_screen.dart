// ignore_for_file: use_build_context_synchronously, unused_field

import 'dart:io';
import 'dart:math';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kajian_fikih/model/comment.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/view/public/post/comment_item.dart';
import 'package:kajian_fikih/view/public/profile/public_ustadz_profile_screen.dart';
import 'package:kajian_fikih/viewmodel/follow_user/follow_cubit.dart';
import 'package:kajian_fikih/viewmodel/follow_user/follow_state.dart';
import 'package:kajian_fikih/viewmodel/post/post_cubit.dart';
import 'package:kajian_fikih/viewmodel/post/post_state.dart';
import 'package:kajian_fikih/viewmodel/post_comment/post_comment_cubit.dart';
import 'package:kajian_fikih/viewmodel/post_comment/post_comment_state.dart';
import 'package:kajian_fikih/viewmodel/post_utils/like_post/like_post_cubit.dart';
import 'package:kajian_fikih/viewmodel/post_utils/like_post/like_post_state.dart';
import 'package:kajian_fikih/viewmodel/post_utils/save_post/save_post_cubit.dart';
import 'package:kajian_fikih/viewmodel/post_utils/save_post/save_post_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostDetailScreen extends StatefulWidget {
  final String uid;
  final String docId;
  final VoidCallback onBack;
  const PostDetailScreen({
    super.key,
    required this.uid,
    required this.docId,
    required this.onBack,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final _commentFormKey = GlobalKey<FormState>();
  final _commentTextController = TextEditingController();
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  late PlayerState _playerState;
  late String initialId;
  late YoutubeMetaData _videoMetaData;
  XFile? file;
  ImagePicker picker = ImagePicker();

  Widget imagePreview() {
    if (file == null) {
      return const SizedBox();
    } else {
      return Stack(
        children: [
          Image.file(
            File(file!.path),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 20,
              height: 20,
              color: const Color.fromARGB(162, 0, 0, 0),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  file = null;
                });
              },
              child: const Icon(
                Icons.close,
                color: whiteColor,
                size: 20,
              ),
            ),
          ),
        ],
      );
    }
  }

  Future<dynamic> uploadDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pilih sumber '),
            actions: [
              TextButton(
                onPressed: () async {
                  XFile? upload =
                      await picker.pickImage(source: ImageSource.camera);

                  setState(() {
                    file = upload;
                  });
                  Navigator.pop(context);
                },
                child: const Icon(Icons.camera_alt),
              ),
              TextButton(
                onPressed: () async {
                  XFile? upload =
                      await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    file = upload;
                  });

                  Navigator.pop(context);
                },
                child: const Icon(Icons.photo_library),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    initPostDetailScreen();

    String initialId = YoutubePlayer.convertUrlToId("").toString();
    _controller = YoutubePlayerController(
      initialVideoId: initialId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        forceHD: false,
        enableCaption: true,
        loop: true,
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initPostDetailScreen() async {
    //get post data
    await context.read<PostCubit>().getPostbyId(widget.docId);
    //get post status (check if post is already liked & saved)
    await context
        .read<LikePostCubit>()
        .getPostLikeStatus(widget.uid, widget.docId);
    await context
        .read<SavePostCubit>()
        .getPostSaveStatus(widget.uid, widget.docId);
    //get follow status
    await context.read<FollowCubit>().getFollowStatus(widget.uid);
  }

  void reinitPostDetailScreen() async {
    //get post data
    await context.read<PostCubit>().getPostbyId(widget.docId);
    //get post status (check if post is already liked & saved)
    await context
        .read<LikePostCubit>()
        .getPostLikeStatus(widget.uid, widget.docId);
    await context
        .read<SavePostCubit>()
        .getPostSaveStatus(widget.uid, widget.docId);
    //get follow status
    await context.read<FollowCubit>().getFollowStatus(widget.uid);
  }

  String formatTimestamp(Timestamp timestamp) {
    // Convert Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();

    // Format the timestamp in the desired output format
    DateFormat outputFormat = DateFormat('HH:mm | dd MMM yyyy |');
    return outputFormat.format(dateTime);
  }

  String formatNumber(int number) {
    const suffixes = ['', 'rb', 'jt', 'm', 't'];
    int magnitude = (number.toString().length - 1) ~/ 3;
    double result = number / pow(1000, magnitude);
    String formattedResult = result.toStringAsFixed(1);
    if (formattedResult.endsWith('.0')) {
      formattedResult = formattedResult.replaceAll('.0', '');
    }
    return '$formattedResult${suffixes[magnitude]}';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
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
        title: Text(
          "Postingan",
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: blackTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Container(
        color: whiteColor,
        height: height,
        width: width,
        child: BlocConsumer<PostCubit, PostState>(
          listener: (BuildContext context, PostState state) {
            if (state is PostErrorState) {
              AnimatedSnackBar.material(
                state.errorMessage,
                type: AnimatedSnackBarType.error,
                snackBarStrategy: RemoveSnackBarStrategy(),
              ).show(context);
            }
            if (state is PostDetailSuccessState) {
              if (state.postDetailResponse.youtubeLink != "") {
                initialId = state.postDetailResponse.youtubeLink!;
              }
            }
          },
          builder: (context, state) {
            if (state is PostDetailSuccessState) {
              final postDetailData = state.postDetailResponse;

              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        SlideLeftAnimation(
                                          page: PublicUstadzProfileScreen(
                                            uid: widget.uid,
                                            onBack: reinitPostDetailScreen,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 16,
                                          child: postDetailData
                                                      .posterProfileImage !=
                                                  ""
                                              ? CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage: NetworkImage(
                                                    postDetailData
                                                        .posterProfileImage,
                                                  ),
                                                )
                                              : Image.asset(
                                                  "assets/profile_image_placeholder.jpg",
                                                ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          postDetailData.poster,
                                          style: GoogleFonts.outfit(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: blackColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  BlocConsumer<FollowCubit, FollowState>(
                                    listener: (BuildContext context,
                                        FollowState followState) {
                                      if (followState is FollowSuccessState) {
                                        context
                                            .read<FollowCubit>()
                                            .getFollowStatus(widget.uid);
                                      }
                                    },
                                    builder: (BuildContext context,
                                        FollowState followState) {
                                      if (followState is FollowLoadingState) {
                                        return const CircularProgressIndicator();
                                      }
                                      if (followState is FollowErrorState) {
                                        return Flexible(
                                          child: Text(
                                              "error : ${followState.errorMessage}"),
                                        );
                                      }
                                      if (followState
                                          is GetFollowStatusSuccessState) {
                                        final currUser =
                                            FirebaseAuth.instance.currentUser;
                                        return Column(
                                          children: [
                                            widget.uid == currUser!.uid
                                                ? const SizedBox()
                                                : ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor: followState
                                                              .isFollowed
                                                          ? greyBackgroundColor
                                                          : primaryColor,
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          const Size(0, 0),
                                                    ),
                                                    onPressed: () {
                                                      context
                                                          .read<FollowCubit>()
                                                          .followUser(
                                                              widget.uid);
                                                      context
                                                          .read<FollowCubit>()
                                                          .getFollowStatus(
                                                              widget.uid);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 5,
                                                      ),
                                                      child: followState
                                                              .isFollowed
                                                          ? Text(
                                                              "Diikuti",
                                                              style: GoogleFonts
                                                                  .outfit(
                                                                fontSize: 12,
                                                                color:
                                                                    blackGreyTextColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            )
                                                          : Text(
                                                              "+ Ikuti",
                                                              style: GoogleFonts
                                                                  .outfit(
                                                                fontSize: 12,
                                                                color:
                                                                    whiteTextColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  postDetailData.postTitle,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: blackColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Column(
                                children: [
                                  postDetailData.youtubeLink != ""
                                      ? YoutubePlayerBuilder(
                                          onExitFullScreen: () {
                                            // The player forces portraitUp after exiting fullscreen.
                                            // This overrides the behaviour.
                                            SystemChrome
                                                .setPreferredOrientations(
                                                    DeviceOrientation.values);
                                          },
                                          player: YoutubePlayer(
                                            controller: _controller,
                                            showVideoProgressIndicator: true,
                                            progressIndicatorColor:
                                                Colors.redAccent,
                                            progressColors:
                                                const ProgressBarColors(
                                              playedColor: Colors.red,
                                              handleColor: Colors.red,
                                              bufferedColor: Colors.redAccent,
                                            ),
                                            onReady: () {
                                              _isPlayerReady = true;
                                            },
                                            topActions: <Widget>[
                                              const SizedBox(width: 8.0),
                                              Expanded(
                                                child: Text(
                                                  _controller.metadata.title,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          builder: (context, player) {
                                            return player;
                                          },
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  postDetailData.imageUrl != ""
                                      ? Image.network(
                                          postDetailData.imageUrl!,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 170,
                                          fit: BoxFit.cover,
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  postDetailData.postContent,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: blackColor,
                                  ),
                                  textAlign: TextAlign.justify,
                                  maxLines: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    formatTimestamp(
                                      postDetailData.timestamp,
                                    ),
                                    style: GoogleFonts.inter(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400,
                                      color: greyTextColor,
                                    ),
                                    textAlign: TextAlign.justify,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    " ${formatNumber(
                                      postDetailData.watchCount,
                                    )}",
                                    style: GoogleFonts.inter(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                    ),
                                    textAlign: TextAlign.justify,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    " Tayangan",
                                    style: GoogleFonts.inter(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400,
                                      color: greyTextColor,
                                    ),
                                    textAlign: TextAlign.justify,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  BlocBuilder<LikePostCubit, LikePostState>(
                                    builder: (BuildContext context,
                                        LikePostState likeState) {
                                      if (likeState is LikePostErrorState) {
                                        return Text(likeState.errorMessage);
                                      }

                                      if (likeState
                                          is GetLikePostStatusSuccessState) {
                                        return InkWell(
                                          onTap: () async {
                                            await context
                                                .read<LikePostCubit>()
                                                .likePost(postDetailData);
                                            await context
                                                .read<LikePostCubit>()
                                                .getPostLikeStatus(
                                                    widget.uid, widget.docId);
                                          },
                                          child: Image.asset(
                                            likeState.isLiked
                                                ? "assets/liked_icon.png"
                                                : "assets/like_icon.png",
                                            width: 24,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        );
                                      } else {
                                        return Image.asset(
                                          "assets/like_icon.png",
                                          width: 24,
                                          fit: BoxFit.fitWidth,
                                        );
                                      }
                                    },
                                  ),
                                  BlocBuilder<SavePostCubit, SavePostState>(
                                    builder: (BuildContext context,
                                        SavePostState saveState) {
                                      if (saveState is SavePostErrorState) {
                                        return Text(saveState.errorMessage);
                                      }

                                      if (saveState
                                          is GetSavePostStatusSuccessState) {
                                        return InkWell(
                                          onTap: () async {
                                            await context
                                                .read<SavePostCubit>()
                                                .savePost(postDetailData);
                                            await context
                                                .read<SavePostCubit>()
                                                .getPostSaveStatus(
                                                    widget.uid, widget.docId);
                                          },
                                          child: Image.asset(
                                            saveState.isSaved
                                                ? "assets/bookmarked_icon.png"
                                                : "assets/bookmark_icon.png",
                                            width: 24,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        );
                                      } else {
                                        return Image.asset(
                                          "assets/bookmark_icon.png",
                                          width: 24,
                                          fit: BoxFit.fitWidth,
                                        );
                                      }
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Share button clicked
                                    },
                                    child: Image.asset(
                                      "assets/share_icon.png",
                                      width: 24,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        //post comments are here
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('posts')
                              .doc(widget.docId)
                              .collection('comments')
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Ada Kesalahan');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            if (snapshot.hasData) {
                              List<DocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 48,
                                ),
                                child: documents.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: documents.length,
                                        itemBuilder: (context, index) {
                                          Map<String, dynamic> commentData =
                                              documents[index].data()
                                                  as Map<String, dynamic>;
                                          PostComment comment =
                                              PostComment.fromFirestore(
                                                  commentData);
                                          return CommentItem(
                                            comment: comment,
                                          );
                                        },
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                          top: 16,
                                        ),
                                        child: Text(
                                          "Belum ada Komentar",
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: blackColor,
                                          ),
                                        ),
                                      ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 16,
                                ),
                                child: Text(
                                  "Belum ada Komentar",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: blackColor,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: whiteColor2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 8,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            imagePreview(),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () => uploadDialog(context),
                                  child: const Icon(
                                    size: 24,
                                    Icons.image,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Flexible(
                                  child: Form(
                                    key: _commentFormKey,
                                    child: TextFormField(
                                      controller: _commentTextController,
                                      decoration: InputDecoration(
                                        suffixIcon: BlocBuilder<
                                            PostCommentCubit, PostCommentState>(
                                          builder: (context,
                                              PostCommentState commentState) {
                                            if (commentState
                                                is PostCommentLoadingState) {
                                              return const Padding(
                                                padding: EdgeInsets.all(16),
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            if (commentState
                                                is PostCommentErrorState) {
                                              _commentTextController.clear;
                                              setState(() {
                                                file = null;
                                              });
                                              return Text(
                                                  "error : ${commentState.errorMessage}");
                                            } else {
                                              return InkWell(
                                                onTap: () {
                                                  if (file != null) {
                                                    context.read<PostCommentCubit>().createComment(
                                                        uid: widget.uid,
                                                        postId: postDetailData
                                                            .docId,
                                                        comment:
                                                            _commentTextController
                                                                .text,
                                                        imageFile: file);
                                                  } else {
                                                    context
                                                        .read<
                                                            PostCommentCubit>()
                                                        .createComment(
                                                          uid: widget.uid,
                                                          postId: postDetailData
                                                              .docId,
                                                          comment:
                                                              _commentTextController
                                                                  .text,
                                                        );
                                                  }
                                                },
                                                child: const Icon(
                                                    size: 20,
                                                    Icons.send_rounded),
                                              );
                                            }
                                          },
                                        ),
                                        hintText: "Tulis Komentar Anda",
                                        hintStyle: GoogleFonts.outfit(
                                          fontSize: 13,
                                          color: greyTextColor,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox(
                height: height,
                width: width,
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
