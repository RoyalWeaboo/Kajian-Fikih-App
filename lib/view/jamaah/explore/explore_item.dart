import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/model/dummy_post.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/view/jamaah/post/post_detail_screen.dart';

class ExploreItem extends StatefulWidget {
  final List<DummyPost>? postingan;
  const ExploreItem({
    super.key,
    this.postingan,
  });

  @override
  State<ExploreItem> createState() => _ExploreItemState();
}

class _ExploreItemState extends State<ExploreItem> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (widget.postingan!.isNotEmpty) {
      final dataPostingan = widget.postingan;
      return ListView.separated(
        shrinkWrap: true,
        itemCount: widget.postingan!.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                SlideLeftAnimation(
                  page: const PostDetailScreen(),
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
                    child: Image.asset(
                      dataPostingan![index].posterImage,
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
                          dataPostingan[index].posterName,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: blackColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        dataPostingan[index].media != ""
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 4,
                                ),
                                child: Image.asset(
                                  dataPostingan[index].media!,
                                  width: width,
                                ),
                              )
                            : const SizedBox(),
                        Text(
                          dataPostingan[index].postText,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: blackColor,
                          ),
                          textAlign: TextAlign.justify,
                          maxLines: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              "${dataPostingan[index].timeStamp} | ",
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
                              "${dataPostingan[index].watchCount}rb",
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
        },
      );
    } else {
      return Center(
        child: Text(
          "Tidak ada postingan",
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: blackColor,
          ),
        ),
      );
    }
  }
}
