import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/model/dummy_comment.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/view/jamaah/post/comment_item.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool isLiked = false;
  bool isBookmarked = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
        child: Stack(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  child: Image.asset(
                                    "assets/profile_placeholder.png",
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Ust. Tomy",
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
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: const Size(0, 0),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: Text(
                                  "+ Ikuti",
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
                                    color: whiteTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 4,
                          ),
                          child: Image.asset(
                            "assets/media_placeholder.png",
                            width: width,
                          ),
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet consectetur. Et sed cursus velit porttitor dui lectus. Tincidunt mattis blandit gravida arcu nisl. Pharetra sit massa elementum rutrum phasellus eu mus pretium. Vestibulum est ac ac eget.",
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: blackColor,
                          ),
                          textAlign: TextAlign.justify,
                          maxLines: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              "12:39 | 23 Sep 2023 | ",
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
                              "22Rb",
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isLiked = !isLiked;
                                  });
                                },
                                child: Image.asset(
                                  isLiked
                                      ? "assets/liked_icon.png"
                                      : "assets/like_icon.png",
                                  width: 24,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isBookmarked = !isBookmarked;
                                  });
                                },
                                child: Image.asset(
                                  isBookmarked
                                      ? "assets/bookmarked_icon.png"
                                      : "assets/bookmark_icon.png",
                                  width: 24,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Image.asset(
                                "assets/share_icon.png",
                                width: 24,
                                fit: BoxFit.fitWidth,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  //comment here
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 48,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dummyComment.length,
                      itemBuilder: (context, index) {
                        return CommentItem(
                          dummyComment: dummyComment[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: whiteColor,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Tulis Komentar Anda",
                        hintStyle: GoogleFonts.outfit(
                          fontSize: 11,
                          color: greyTextColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
