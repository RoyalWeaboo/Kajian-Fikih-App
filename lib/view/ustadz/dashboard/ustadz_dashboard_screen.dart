import 'package:calendar_slider/calendar_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/model/offline_event.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/widgets/ustadz_bottom_navbar.dart';
import 'package:kajian_fikih/view/jamaah/dashboard/category_item.dart';
import 'package:kajian_fikih/view/public/notification/notification_screen.dart';
import 'package:kajian_fikih/view/jamaah/offline_event/offline_event_detail_screen.dart';
import 'package:kajian_fikih/view/ustadz/post/create_post_screen.dart';
import 'package:kajian_fikih/viewmodel/dashboard_ustadz/dashboard_event.cubit.dart';
import 'package:kajian_fikih/viewmodel/dashboard_ustadz/dashboard_event_state.dart';
import 'package:kajian_fikih/viewmodel/profile_ustadz/profile_ustadz_cubit.dart';
import 'package:kajian_fikih/viewmodel/profile_ustadz/profile_ustadz_state.dart';
import 'package:kajian_fikih/viewmodel/user_detail/user_detail_cubit.dart';
import 'package:kajian_fikih/viewmodel/user_detail/user_detail_state.dart';

class UstadzDashboardScreen extends StatefulWidget {
  const UstadzDashboardScreen({super.key});

  @override
  State<UstadzDashboardScreen> createState() => _UstadzDashboardScreenState();
}

class _UstadzDashboardScreenState extends State<UstadzDashboardScreen> {
  String title = "";
  String postDate = "";
  String content = "";
  String startTime = "";
  String endTime = "";
  bool callEventFlag = false;

  @override
  void initState() {
    super.initState();
    initDashboardPage();
  }

  Future initDashboardPage() async {
    context.read<ProfileUstadzCubit>().getProfileDetail();
    final user = FirebaseAuth.instance.currentUser;
    context.read<DashboardEventCubit>().getUserEventsForDateRange(user!.uid, 3);
    context.read<UserDetailCubit>().getUserDetail();
  }

  List<OfflineEvent?> getEventByDate(
      List<OfflineEvent> eventsList, DateTime targetDate) {
    List<OfflineEvent> events = [];
    for (var event in eventsList) {
      List<String> dateParts =
          event.date.split(' '); // Split the string by space

      // Extract day, month, and year components
      int day = int.parse(dateParts[0]);
      int month =
          getMonthIndex(dateParts[1]); // Convert month name to month index
      int year = int.parse(dateParts[2]);
      DateTime eventDate = DateTime(year, month, day);

      if (eventDate.year == targetDate.year &&
          eventDate.month == targetDate.month &&
          eventDate.day == targetDate.day) {
        events.add(event);
      }
    }
    return events;
  }

  int getMonthIndex(String monthName) {
    switch (monthName.toLowerCase()) {
      case 'januari':
        return 1;
      case 'februari':
        return 2;
      case 'maret':
        return 3;
      case 'april':
        return 4;
      case 'mei':
        return 5;
      case 'juni':
        return 6;
      case 'juli':
        return 7;
      case 'agustus':
        return 8;
      case 'september':
        return 9;
      case 'oktober':
        return 10;
      case 'november':
        return 11;
      case 'desember':
        return 12;
      default:
        throw FormatException('Invalid month name: $monthName');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 16,
          ),
          child: Image.asset(
            "assets/main_logo_white.png",
            width: 24,
          ),
        ),
        title: Text(
          "Kajian Fikih",
          style: GoogleFonts.outfit(
            color: whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  SlideLeftAnimation(
                    page: const NotificationScreen(),
                  ),
                );
              },
              child: Image.asset(
                'assets/notifications.png',
                width: 24,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                'assets/dashboard_background.png',
                width: width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<UserDetailCubit, UserDetailState>(
                    builder: (BuildContext context, UserDetailState userState) {
                      if (userState is UserDetailErrorState) {
                        return Text(
                          "Error : ${userState.errorMessage}",
                          style: GoogleFonts.outfit(
                            color: secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        );
                      }
                      if (userState is UserDetailSuccessState) {
                        return Text(
                          "Selamat Datang, Ust.${userState.userData.username} !",
                          style: GoogleFonts.outfit(
                            color: secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  Text(
                    "Sampaikan yang harus disampaikan.",
                    style: GoogleFonts.outfit(
                      color: whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<DashboardEventCubit, DashboardEventState>(
                    builder:
                        (BuildContext context, DashboardEventState eventState) {
                      if (eventState is DashboardEventLoadingState) {
                        Material(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Container(
                            height: 100,
                            width: width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      }
                      if (eventState is DashboardEventErrorState) {
                        Text(eventState.errorMessage);
                      }
                      if (eventState is DashboardEventSuccessState) {
                        // to handle "cannot build because the framework is already building"
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          //get today events
                          if (!callEventFlag) {
                            //used only once to get all events once, if not called once, will be called multiple times (this is not wanted when calling onDateSelected method)
                            callEventFlag = true;
                            final todayEvents = getEventByDate(
                                eventState.offlineEventResponse,
                                DateTime.now());
                            if (todayEvents.isNotEmpty) {
                              setState(() {
                                title = todayEvents[0]?.postTitle ?? "";
                                postDate = todayEvents[0]?.date ?? "";
                                content = todayEvents[0]?.postContent ?? "";
                                startTime = todayEvents[0]?.timeStart ?? "";
                                endTime = todayEvents[0]?.timeEnd ?? "";
                              });
                            } else {
                              setState(() {
                                title = "Tidak Ada Kajian";
                                postDate = "-";
                                content =
                                    "Tidak Ada jadwal kajian Offline pada hari ini";
                                startTime = "-";
                                endTime = "-";
                              });
                            }
                          }
                        });

                        return Material(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Container(
                            padding: const EdgeInsets.only(
                              right: 16,
                              top: 16,
                              bottom: 16,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    "Kalender",
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      color: blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                CalendarSlider(
                                  fullCalendar: false,
                                  monthYearButtonBackgroundColor:
                                      Colors.transparent,
                                  monthYearTextColor: blackColor,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .subtract(const Duration(days: 4)),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 3)),
                                  selectedTileBackgroundColor: secondaryColor,
                                  tileBackgroundColor: primaryColor,
                                  dateColor: whiteColor,
                                  onDateSelected: (date) {
                                    var events = getEventByDate(
                                        eventState.offlineEventResponse, date);
                                    if (events.isNotEmpty) {
                                      setState(() {
                                        title = events[0]?.postTitle ?? "";
                                        postDate = events[0]?.date ?? "";
                                        content = events[0]?.postContent ?? "";
                                        startTime = events[0]?.timeStart ?? "";
                                        endTime = events[0]?.timeEnd ?? "";
                                      });
                                    } else {
                                      setState(() {
                                        title = "Tidak Ada Kajian";
                                        postDate = "";
                                        content =
                                            "Tidak Ada jadwal kajian Offline pada hari ini";
                                        startTime = "00.00";
                                        endTime = "00.00";
                                      });
                                    }
                                  },
                                ),
                                eventState.offlineEventResponse.isNotEmpty
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              title,
                                              style: GoogleFonts.outfit(
                                                color: blackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              // "08.00 - 11.00 WIB ${eventState.offlineEventResponse[0].date}",
                                              "$startTime - $endTime WIB $postDate",
                                              style: GoogleFonts.inter(
                                                color: blackColor,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "“$content”.",
                                              style: GoogleFonts.outfit(
                                                color: blackColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tidak Ada Kajian",
                                              style: GoogleFonts.outfit(
                                                color: blackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "",
                                              style: GoogleFonts.inter(
                                                color: blackColor,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "Tidak Ada jadwal kajian Offline pada hari ini",
                                              style: GoogleFonts.outfit(
                                                color: blackColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Kajian Terakhir Anda",
                    style: GoogleFonts.outfit(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  BlocBuilder<UserDetailCubit, UserDetailState>(
                    builder: (BuildContext context, UserDetailState userState) {
                      if (userState is UserDetailSuccessState) {
                        return SizedBox(
                          height: height * 0.77,
                          child: DefaultTabController(
                            length: 6,
                            child: Scaffold(
                              body: BlocBuilder<ProfileUstadzCubit,
                                  ProfileUstadzState>(
                                builder: (context, state) {
                                  if (state is ProfileUstadzLoadingState) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  if (state is ProfileUstadzErrorState) {
                                    return Center(
                                      child: Text(state.errorMessage),
                                    );
                                  }
                                  if (state is ProfileUstadzSuccessState) {
                                    List<String> category = [
                                      "Hadist",
                                      "Sholat",
                                      "Zakat",
                                      "AlQuran",
                                      "Puasa"
                                    ];

                                    List<OfflineEvent> hadist = (state
                                                .ustadzProfileDetail
                                                ?.offlineEvents ??
                                            [])
                                        .where((event) =>
                                            event.category == category[0])
                                        .toList();
                                    List<OfflineEvent> sholat = (state
                                                .ustadzProfileDetail
                                                ?.offlineEvents ??
                                            [])
                                        .where((event) =>
                                            event.category == "Sholat")
                                        .toList();
                                    List<OfflineEvent> zakat = (state
                                                .ustadzProfileDetail
                                                ?.offlineEvents ??
                                            [])
                                        .where((event) =>
                                            event.category == "Zakat")
                                        .toList();
                                    List<OfflineEvent> quran = (state
                                                .ustadzProfileDetail
                                                ?.offlineEvents ??
                                            [])
                                        .where((event) =>
                                            event.category == "AlQuran")
                                        .toList();
                                    List<OfflineEvent> puasa = (state
                                                .ustadzProfileDetail
                                                ?.offlineEvents ??
                                            [])
                                        .where((event) =>
                                            event.category == "Puasa")
                                        .toList();

                                    return Scaffold(
                                      appBar: TabBar(
                                        isScrollable: true,
                                        tabAlignment: TabAlignment.start,
                                        labelStyle: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                        dividerColor: Colors.transparent,
                                        indicatorColor: Colors.transparent,
                                        unselectedLabelColor: blackColor,
                                        labelPadding:
                                            const EdgeInsets.only(right: 12),
                                        tabs: const [
                                          Tab(
                                            child: Text(
                                              "Semua",
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              "Hadist",
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              "Sholat",
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              "Zakat",
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              "Al-Qur'an",
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              "Puasa",
                                            ),
                                          ),
                                        ],
                                      ),
                                      body: Expanded(
                                        child: TabBarView(
                                          children: [
                                            //TAB 1, Semua
                                            (state.ustadzProfileDetail
                                                            ?.offlineEvents ??
                                                        [])
                                                    .isNotEmpty
                                                ? GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 224,
                                                    ),
                                                    shrinkWrap: true,
                                                    itemCount: (state
                                                                .ustadzProfileDetail
                                                                ?.offlineEvents ??
                                                            [])
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final listData = (state
                                                              .ustadzProfileDetail
                                                              ?.offlineEvents ??
                                                          [])[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            SlideLeftAnimation(
                                                              page:
                                                                  OfflineEventDetailScreen(
                                                                docId: listData
                                                                    .docId,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child:
                                                            DashboardCategoryItem(
                                                          backgroundImage:
                                                              listData
                                                                  .imageUrl!,
                                                          title: listData
                                                              .postTitle,
                                                          description: listData
                                                              .postContent,
                                                          isAssetImage: false,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Container(
                                                    color: whiteColor,
                                                    height: 300,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.1,
                                                        ),
                                                        Text(
                                                          "Belum ada Kajian",
                                                          style: GoogleFonts
                                                              .outfit(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color:
                                                                blackTextColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            //TAB 2, Hadist
                                            hadist.isNotEmpty
                                                ? GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 224,
                                                    ),
                                                    shrinkWrap: true,
                                                    itemCount: hadist.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final listData =
                                                          hadist[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            SlideLeftAnimation(
                                                              page:
                                                                  OfflineEventDetailScreen(
                                                                docId: listData
                                                                    .docId,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child:
                                                            DashboardCategoryItem(
                                                          backgroundImage:
                                                              listData
                                                                  .imageUrl!,
                                                          title: listData
                                                              .postTitle,
                                                          description: listData
                                                              .postContent,
                                                          isAssetImage: false,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Container(
                                                    color: whiteColor,
                                                    height: 300,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.1,
                                                        ),
                                                        Text(
                                                          "Belum ada Kajian",
                                                          style: GoogleFonts
                                                              .outfit(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color:
                                                                blackTextColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            //TAB 3, Sholat
                                            sholat.isNotEmpty
                                                ? GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 224,
                                                    ),
                                                    shrinkWrap: true,
                                                    itemCount: sholat.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final listData =
                                                          sholat[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            SlideLeftAnimation(
                                                              page:
                                                                  OfflineEventDetailScreen(
                                                                docId: listData
                                                                    .docId,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child:
                                                            DashboardCategoryItem(
                                                          backgroundImage:
                                                              listData
                                                                  .imageUrl!,
                                                          title: listData
                                                              .postTitle,
                                                          description: listData
                                                              .postContent,
                                                          isAssetImage: false,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Container(
                                                    color: whiteColor,
                                                    height: 300,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.1,
                                                        ),
                                                        Text(
                                                          "Belum ada Kajian",
                                                          style: GoogleFonts
                                                              .outfit(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color:
                                                                blackTextColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            //TAB 4, Zakat
                                            zakat.isNotEmpty
                                                ? GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 224,
                                                    ),
                                                    shrinkWrap: true,
                                                    itemCount: zakat.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final listData =
                                                          zakat[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            SlideLeftAnimation(
                                                              page:
                                                                  OfflineEventDetailScreen(
                                                                docId: listData
                                                                    .docId,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child:
                                                            DashboardCategoryItem(
                                                          backgroundImage:
                                                              listData
                                                                  .imageUrl!,
                                                          title: listData
                                                              .postTitle,
                                                          description: listData
                                                              .postContent,
                                                          isAssetImage: false,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Container(
                                                    color: whiteColor,
                                                    height: 300,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.1,
                                                        ),
                                                        Text(
                                                          "Belum ada Kajian",
                                                          style: GoogleFonts
                                                              .outfit(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color:
                                                                blackTextColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            //TAB 5, Al-Qur'an
                                            quran.isNotEmpty
                                                ? GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 224,
                                                    ),
                                                    shrinkWrap: true,
                                                    itemCount: quran.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final listData =
                                                          quran[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            SlideLeftAnimation(
                                                              page:
                                                                  OfflineEventDetailScreen(
                                                                docId: listData
                                                                    .docId,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child:
                                                            DashboardCategoryItem(
                                                          backgroundImage:
                                                              listData
                                                                  .imageUrl!,
                                                          title: listData
                                                              .postTitle,
                                                          description: listData
                                                              .postContent,
                                                          isAssetImage: false,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Container(
                                                    color: whiteColor,
                                                    height: 300,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.1,
                                                        ),
                                                        Text(
                                                          "Belum ada Kajian",
                                                          style: GoogleFonts
                                                              .outfit(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color:
                                                                blackTextColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            //TAB 6, Puasa
                                            puasa.isNotEmpty
                                                ? GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 224,
                                                    ),
                                                    shrinkWrap: true,
                                                    itemCount: puasa.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final listData =
                                                          puasa[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            SlideLeftAnimation(
                                                              page:
                                                                  OfflineEventDetailScreen(
                                                                docId: listData
                                                                    .docId,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child:
                                                            DashboardCategoryItem(
                                                          backgroundImage:
                                                              listData
                                                                  .imageUrl!,
                                                          title: listData
                                                              .postTitle,
                                                          description: listData
                                                              .postContent,
                                                          isAssetImage: false,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Container(
                                                    color: whiteColor,
                                                    height: 300,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.1,
                                                        ),
                                                        Text(
                                                          "Belum ada Kajian",
                                                          style: GoogleFonts
                                                              .outfit(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color:
                                                                blackTextColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          color: secondaryColor,
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
              context,
              SlideLeftAnimation(
                page: const CreatePostScreen(),
              ),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Text(
            "+",
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: whiteColor,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: UstadzBottomNavbarComponent(),
    );
  }
}
