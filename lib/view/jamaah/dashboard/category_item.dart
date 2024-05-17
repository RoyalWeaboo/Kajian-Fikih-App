import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/constants/color.dart';

class DashboardCategoryItem extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final String description;
  final bool? isAssetImage;
  const DashboardCategoryItem({
    super.key,
    required this.backgroundImage,
    required this.title,
    required this.description,
    this.isAssetImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          isAssetImage != null
              ? isAssetImage!
                  ? Image.asset(
                      backgroundImage,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: backgroundImage != ""
                          ? Container(
                              decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(backgroundImage),
                                fit: BoxFit.cover,
                              ),
                            ))
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 64),
                                child: Image.asset(
                                  "assets/no_image_icon.png",
                                  color: Colors.black,
                                  height: 32,
                                ),
                              ),
                            ),
                    )
              : Image.asset(
                  backgroundImage,
                ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/category_shadow.png",
              width: MediaQuery.of(context).size.width * 0.445,
            ),
          ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 8,
            child: SizedBox(
              width: 138,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      color: secondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.outfit(
                      color: whiteColor,
                      fontSize: 7,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
