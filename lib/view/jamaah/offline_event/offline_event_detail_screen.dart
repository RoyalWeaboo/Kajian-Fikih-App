import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/constants/color.dart';

class OfflineEventDetailScreen extends StatefulWidget {
  const OfflineEventDetailScreen({super.key});

  @override
  State<OfflineEventDetailScreen> createState() =>
      _OfflineEventDetailScreenState();
}

class _OfflineEventDetailScreenState extends State<OfflineEventDetailScreen> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
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
                      "Kajian Solawat Habib Lutfi Bin Yahya",
                      style: GoogleFonts.outfit(
                        fontSize: 16,
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
                          "Pekalongan",
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
                      "Lorem ipsum dolor sit amet consectetur. Morbi amet nec purus consectetur ipsum. Sollicitudin consectetur porttitor purus nam morbi. Et sollicitudin augue viverra id lacus urna adipiscing. Adipiscing sit posuere praesent velit morbi id.",
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
                          "Noyontaan No. 26, Kec. Pekalongan Barat, Kota Pekalongan",
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: blackGreyTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Image.asset(
                      "assets/map_placeholder.png",
                      width: width,
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
