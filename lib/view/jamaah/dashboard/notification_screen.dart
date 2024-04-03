import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/model/dummy_notification.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/view/jamaah/dashboard/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Notifikasi",
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: blackTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        color: whiteColor,
        child: ListView.builder(
          itemCount: jamaahDummyTestNotification.length,
          itemBuilder: (context, index) {
            final notificationData = jamaahDummyTestNotification[index];
            return NotificationItem(
              notificationTitle: notificationData.notificationTitle,
              notificationDescription: notificationData.notificationDescription,
            );
          },
        ),
      ),
    );
  }
}
