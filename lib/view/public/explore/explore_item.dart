// ignore_for_file: use_build_context_synchronously, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kajian_fikih/model/post.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/view/public/post/post_detail_screen.dart';
import 'package:kajian_fikih/viewmodel/post/post_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExploreItem extends StatefulWidget {
  final Post postData;
  final bool followedPost;
  final VoidCallback onBack;
  const ExploreItem(
      {super.key,
      required this.postData,
      required this.followedPost,
      required this.onBack});

  @override
  State<ExploreItem> createState() => _ExploreItemState();
}

class _ExploreItemState extends State<ExploreItem> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  String initialId = "";

  @override
  void initState() {
    super.initState();
    if (widget.postData.youtubeLink != "") {
      initialId =
          YoutubePlayer.convertUrlToId(widget.postData.youtubeLink!).toString();
    }
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () async {
        await context.read<PostCubit>().addViewCount(
              widget.postData.uid,
              widget.postData.docId,
              widget.postData.watchCount,
            );

        Navigator.push(
          context,
          SlideLeftAnimation(
            page: PostDetailScreen(
              uid: widget.postData.uid,
              docId: widget.postData.docId,
              onBack: widget.onBack,
            ),
          ),
        );
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 16,
              child: widget.postData.posterProfileImage != ""
                  ? CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        widget.postData.posterProfileImage,
                      ),
                    )
                  : Image.asset(
                      "assets/profile_image_placeholder.jpg",
                    ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.postData.poster,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: blackColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.postData.postTitle,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: blackColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                    ),
                    child: Column(
                      children: [
                        widget.postData.youtubeLink != ""
                            ? YoutubePlayerBuilder(
                                onExitFullScreen: () {
                                  // The player forces portraitUp after exiting fullscreen.
                                  // This overrides the behaviour.
                                  SystemChrome.setPreferredOrientations(
                                      DeviceOrientation.values);
                                },
                                player: YoutubePlayer(
                                  controller: _controller,
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.redAccent,
                                  progressColors: const ProgressBarColors(
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
                                        overflow: TextOverflow.ellipsis,
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
                        widget.postData.imageUrl != ""
                            ? Image.network(
                                widget.postData.imageUrl!,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4,
                      right: 16,
                    ),
                    child: Text(
                      widget.postData.postContent,
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
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "${formatDateString(widget.postData.timestamp)} | ",
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
                        "${widget.postData.watchCount}",
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String formatDateString(Timestamp timestamp) {
    // Parse the input date string
    DateTime dateTime = timestamp.toDate();

    // Format the date into the desired format
    String formattedDate = DateFormat("HH:mm | dd MMM yy").format(dateTime);

    return formattedDate;
  }
}
