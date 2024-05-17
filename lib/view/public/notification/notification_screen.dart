import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/view/public/notification/notification_item.dart';
import 'package:kajian_fikih/view/jamaah/offline_event/offline_event_detail_screen.dart';
import 'package:kajian_fikih/view/public/post/post_detail_screen.dart';
import 'package:kajian_fikih/viewmodel/notification/notification_cubit.dart';
import 'package:kajian_fikih/viewmodel/notification/notification_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getAllNotification();
  }

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
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NotificationErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          if (state is NotificationSuccessState) {
            if (state.postNotificationResponse.isNotEmpty) {
              return Container(
                width: width,
                height: height,
                color: whiteColor,
                child: ListView.builder(
                  itemCount: state.postNotificationResponse.length,
                  itemBuilder: (context, index) {
                    final notificationData = state.postNotificationResponse;
                    return InkWell(
                      onTap: () {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser != null) {
                          //notification for online post
                          if (notificationData[index].postType == "online") {
                            Navigator.push(
                              context,
                              SlideLeftAnimation(
                                page: PostDetailScreen(
                                  uid: currentUser.uid,
                                  docId: notificationData[index].postDocId,
                                  onBack: () {},
                                ),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              SlideLeftAnimation(
                                page: OfflineEventDetailScreen(
                                  docId: notificationData[index].postDocId,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: NotificationItem(
                        notificationTitle:
                            notificationData[index].notificationTitle,
                        notificationDescription:
                            notificationData[index].notificationText,
                      ),
                    );
                  },
                ),
              );
            } else {
              return SizedBox(
                height: height - 32,
                width: width,
                child: Center(
                  child: Text(
                    "Belum ada notifikasi",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: blackColor,
                    ),
                  ),
                ),
              );
            }
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
