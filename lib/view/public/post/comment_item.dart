import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kajian_fikih/model/comment.dart';
import 'package:kajian_fikih/utils/constants/color.dart';

class CommentItem extends StatelessWidget {
  final PostComment comment;
  const CommentItem({super.key, required this.comment});

  String formatTimestamp(Timestamp timestamp) {
    // Convert Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();

    // Format the timestamp in the desired output format
    DateFormat outputFormat = DateFormat('HH:mm | dd MMM yyyy');
    return outputFormat.format(dateTime);
  }

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
                child: comment.commenterProfileImage != ""
                    ? CircleAvatar(
                        backgroundImage:
                            NetworkImage(comment.commenterProfileImage),
                        backgroundColor: Colors.transparent,
                      )
                    : Image.asset(
                        "assets/profile_image_placeholder.jpg",
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
                    comment.commenter,
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
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                    ),
                    child: Text(
                      comment.comment,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  comment.imageUrl != null
                      ? Container(
                          margin: const EdgeInsets.only(
                            top: 4,
                            right: 16,
                          ),
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            comment.imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    formatTimestamp(comment.timestamp),
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
