import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/model/dummy_comment.dart';
import 'package:kajian_fikih/utils/constants/color.dart';

class CommentItem extends StatelessWidget {
  final DummyComment dummyComment;
  const CommentItem({super.key, required this.dummyComment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: CircleAvatar(
                radius: 16,
                child: Image.asset(
                  "assets/profile_placeholder.png",
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dummyComment.commenter,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: blackColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    dummyComment.comment,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: blackColor,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    dummyComment.timeStamp,
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
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
