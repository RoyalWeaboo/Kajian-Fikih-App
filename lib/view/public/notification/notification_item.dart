import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/constants/color.dart';

class NotificationItem extends StatelessWidget {
  final String notificationTitle;
  final String notificationDescription;
  final String? timeStamp;
  const NotificationItem({
    super.key,
    required this.notificationTitle,
    required this.notificationDescription,
    this.timeStamp,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      width: width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/info_icon.png",
                width: 24,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Info",
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: blackGreyTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      notificationTitle,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: blackGreyTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      notificationDescription,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: greyTextColor2,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 8,
              left: 32,
            ),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
