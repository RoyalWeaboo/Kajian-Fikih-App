import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/viewmodel/post/post_cubit.dart';
import 'package:kajian_fikih/viewmodel/post/post_state.dart';
import 'package:url_launcher/url_launcher.dart';

class OfflineEventDetailScreen extends StatefulWidget {
  // final OfflineEvent offlineEventData;
  final String docId;
  const OfflineEventDetailScreen({
    super.key,
    // required this.offlineEventData,
    required this.docId,
  });

  @override
  State<OfflineEventDetailScreen> createState() =>
      _OfflineEventDetailScreenState();
}

class _OfflineEventDetailScreenState extends State<OfflineEventDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().getEventbyId(widget.docId);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Kajian Offline",
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: blackTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        color: whiteColor,
        child: SingleChildScrollView(
          child: BlocBuilder<PostCubit, PostState>(
            builder: (context, state) {
              if (state is PostLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is PostErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              if (state is OfflineEventSuccessState) {
                return state.offlineEventResponse.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          state.offlineEventResponse[0].imageUrl != ""
                              ? Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(state
                                            .offlineEventResponse[0].imageUrl!),
                                        fit: BoxFit.cover),
                                  ))
                              : Image.asset(
                                  "assets/offline_event_placeholder.png",
                                  width: width,
                                  fit: BoxFit.fitWidth,
                                ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.offlineEventResponse[0].postTitle,
                                  style: GoogleFonts.outfit(
                                    fontSize: 18,
                                    color: blackTextColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
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
                                      state.offlineEventResponse[0].location,
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
                                Text(
                                  "Ustadz",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: blackTextColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      child: state.offlineEventResponse[0]
                                                  .posterProfileImage !=
                                              ""
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  state.offlineEventResponse[0]
                                                      .posterProfileImage),
                                              backgroundColor:
                                                  Colors.transparent,
                                            )
                                          : Image.asset(
                                              "assets/profile_image_placeholder.jpg",
                                            ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      state.offlineEventResponse[0].poster,
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: blackColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Tentang Kajian",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: blackTextColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  state.offlineEventResponse[0].postContent !=
                                          ""
                                      ? state
                                          .offlineEventResponse[0].postContent
                                      : "Tidak ada deskripsi terkait Kajian ini",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: blackTextColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Tanggal dan Waktu",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: blackTextColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "${state.offlineEventResponse[0].date}, ${state.offlineEventResponse[0].timeStart} - ${state.offlineEventResponse[0].timeEnd} WIB",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: blackTextColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Lokasi",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: blackTextColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (state.offlineEventResponse[0]
                                            .locationUrl !=
                                        "") {
                                      launchUrl(Uri.parse(state
                                          .offlineEventResponse[0]
                                          .locationUrl));
                                    }
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/location_icon.png",
                                        width: 16,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: state
                                                          .offlineEventResponse[
                                                              0]
                                                          .locationAddress !=
                                                      ""
                                                  ? state
                                                      .offlineEventResponse[0]
                                                      .locationAddress
                                                  : "Lokasi tidak ditentukan",
                                              style: GoogleFonts.outfit(
                                                fontSize: 12,
                                                color: blackGreyTextColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  state.offlineEventResponse[0]
                                                              .locationUrl !=
                                                          ""
                                                      ? " [Buka di Google Maps]"
                                                      : "",
                                              style: GoogleFonts.outfit(
                                                fontSize: 12,
                                                color: textURLColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                      )
                    : const Text("Kajian tidak ditemukan");
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
