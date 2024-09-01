import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/model/offline_event.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/preferences/preferences_utils.dart';
import 'package:kajian_fikih/utils/widgets/bottom_navbar.dart';
import 'package:kajian_fikih/view/jamaah/dashboard/category_item.dart';
import 'package:kajian_fikih/view/jamaah/explore_category/explore_category_screen.dart';
import 'package:kajian_fikih/view/public/notification/notification_screen.dart';
import 'package:kajian_fikih/view/jamaah/offline_event/offline_event_detail_screen.dart';
import 'package:kajian_fikih/viewmodel/dashboard_jamaah/dashboard_jamaah_cubit.dart';
import 'package:kajian_fikih/viewmodel/dashboard_jamaah/dashboard_jamaah_state.dart';
import 'package:kajian_fikih/viewmodel/history/history_cubit.dart';
import 'package:kajian_fikih/viewmodel/user_detail/user_detail_cubit.dart';
import 'package:kajian_fikih/viewmodel/user_detail/user_detail_state.dart';

class JamaahDashboardScreen extends StatefulWidget {
  const JamaahDashboardScreen({super.key});

  @override
  State<JamaahDashboardScreen> createState() => _JamaahDashboardScreenState();
}

class _JamaahDashboardScreenState extends State<JamaahDashboardScreen> {
  late PreferencesUtils preferencesUtils;

  @override
  void initState() {
    super.initState();
    initPreferences();
    context.read<UserDetailCubit>().getUserDetail();
    context.read<DashboardJamaahCubit>().getOfflinePost();
  }

  Future initPreferences() async {
    preferencesUtils = PreferencesUtils();
    await preferencesUtils.init();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
              child: Image.asset('assets/dashboard_background.png'),
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
                  Text(
                    "Jelajahi Kedalaman Ilmu Islam",
                    style: GoogleFonts.outfit(
                      color: secondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Pintumu menuju Pemahaman yang Terang",
                    style: GoogleFonts.outfit(
                      color: whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: height * 0.28,
                    width: width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              SlideLeftAnimation(
                                page: const ExploreByCategoryScreen(
                                  category: "Hadist",
                                ),
                              ),
                            );
                          },
                          child: const DashboardCategoryItem(
                              backgroundImage: 'assets/hadist.png',
                              title: 'Hadist',
                              description:
                                  'Eksplor lebih jauh tentang hadist.'),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              SlideLeftAnimation(
                                page: const ExploreByCategoryScreen(
                                  category: "Sholat",
                                ),
                              ),
                            );
                          },
                          child: const DashboardCategoryItem(
                              backgroundImage: 'assets/sholat.png',
                              title: 'Sholat',
                              description:
                                  'Eksplor lebih jauh tentang Sholat.'),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              SlideLeftAnimation(
                                page: const ExploreByCategoryScreen(
                                  category: "Zakat",
                                ),
                              ),
                            );
                          },
                          child: const DashboardCategoryItem(
                              backgroundImage: 'assets/zakat.png',
                              title: 'Zakat',
                              description: 'Eksplor lebih jauh tentang Zakat.'),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              SlideLeftAnimation(
                                page: const ExploreByCategoryScreen(
                                  category: "AlQuran",
                                ),
                              ),
                            );
                          },
                          child: const DashboardCategoryItem(
                              backgroundImage: 'assets/quran.png',
                              title: 'Al-Qur\'an',
                              description: 'Eksplor lebih tentang Qur\'an.'),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              SlideLeftAnimation(
                                page: const ExploreByCategoryScreen(
                                  category: "Puasa",
                                ),
                              ),
                            );
                          },
                          child: const DashboardCategoryItem(
                              backgroundImage: 'assets/puasa.png',
                              title: 'Puasa',
                              description: 'Eksplor lebih jauh tentang Puasa.'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Ikuti Kajian Islamic",
                    style: GoogleFonts.outfit(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  BlocBuilder<UserDetailCubit, UserDetailState>(
                    builder: (BuildContext context, UserDetailState userState) {
                      if (userState is UserDetailSuccessState) {
                        String currentUserLocation = "";
                        List<String> locations = [
                          "Semarang",
                          "Jepara",
                          "Demak",
                          "Pekalongan",
                          "Purwokerto",
                          "Solo"
                        ];

                        locations.remove(currentUserLocation);

                        return SizedBox(
                          width: width,
                          height: height * 0.77,
                          child: DefaultTabController(
                            length: 6,
                            child: Scaffold(
                              body: BlocBuilder<DashboardJamaahCubit,
                                  DashboardJamaahState>(
                                builder: (context, state) {
                                  if (state is DashboardJamaahLoadingState) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (state is DashboardJamaahErrorState) {
                                    return Text(
                                        "error : ${state.errorMessage}");
                                  }
                                  if (state is DashboardJamaahSuccessState) {
                                    List<OfflineEvent> closestLocation = state
                                        .offlineEventResponse
                                        .where((event) =>
                                            event.location ==
                                            currentUserLocation)
                                        .toList();
                                    List<OfflineEvent> locations1 = state
                                        .offlineEventResponse
                                        .where((event) =>
                                            event.location == locations[0])
                                        .toList();
                                    List<OfflineEvent> locations2 = state
                                        .offlineEventResponse
                                        .where((event) =>
                                            event.location == locations[1])
                                        .toList();
                                    List<OfflineEvent> locations3 = state
                                        .offlineEventResponse
                                        .where((event) =>
                                            event.location == locations[2])
                                        .toList();
                                    List<OfflineEvent> locations4 = state
                                        .offlineEventResponse
                                        .where((event) =>
                                            event.location == locations[3])
                                        .toList();
                                    List<OfflineEvent> locations5 = state
                                        .offlineEventResponse
                                        .where((event) =>
                                            event.location == locations[4])
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
                                        tabs: [
                                          Tab(
                                            child: Text(
                                              "Terdekat",
                                              style: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              locations[0],
                                              style: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              locations[1],
                                              style: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              locations[2],
                                              style: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              locations[3],
                                              style: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              locations[4],
                                              style: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      body: TabBarView(
                                        children: [
                                          //TAB 1, Closest Location
                                          closestLocation.isNotEmpty
                                              ? GridView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisExtent: 224,
                                                  ),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      closestLocation.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final listData =
                                                        closestLocation[index];
                                                    return InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                HistoryCubit>()
                                                            .addHistory(
                                                                listData);
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
                                                            listData.imageUrl!,
                                                        title:
                                                            listData.postTitle,
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
                                                        height: height * 0.15,
                                                      ),
                                                      Text(
                                                        "Tidak ada Kajian",
                                                        style:
                                                            GoogleFonts.outfit(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                          color: blackTextColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          //TAB 2, Location 1
                                          locations1.isNotEmpty
                                              ? GridView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisExtent: 224,
                                                  ),
                                                  shrinkWrap: true,
                                                  itemCount: locations1.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final listData =
                                                        locations1[index];
                                                    return InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                HistoryCubit>()
                                                            .addHistory(
                                                                listData);
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
                                                            listData.imageUrl!,
                                                        title:
                                                            listData.postTitle,
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
                                                        height: height * 0.15,
                                                      ),
                                                      Text(
                                                        "Tidak ada Kajian",
                                                        style:
                                                            GoogleFonts.outfit(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                          color: blackTextColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          //TAB 3, Location 2
                                          locations2.isNotEmpty
                                              ? GridView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisExtent: 224,
                                                  ),
                                                  shrinkWrap: true,
                                                  itemCount: locations2.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final listData =
                                                        locations2[index];
                                                    return InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                HistoryCubit>()
                                                            .addHistory(
                                                                listData);
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
                                                            listData.imageUrl!,
                                                        title:
                                                            listData.postTitle,
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
                                                        height: height * 0.15,
                                                      ),
                                                      Text(
                                                        "Tidak ada Kajian",
                                                        style:
                                                            GoogleFonts.outfit(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                          color: blackTextColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          //TAB 4, Location 3
                                          locations3.isNotEmpty
                                              ? GridView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisExtent: 224,
                                                  ),
                                                  shrinkWrap: true,
                                                  itemCount: locations3.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final listData =
                                                        locations3[index];
                                                    return InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                HistoryCubit>()
                                                            .addHistory(
                                                                listData);
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
                                                            listData.imageUrl!,
                                                        title:
                                                            listData.postTitle,
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
                                                        height: height * 0.15,
                                                      ),
                                                      Text(
                                                        "Tidak ada Kajian",
                                                        style:
                                                            GoogleFonts.outfit(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                          color: blackTextColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          //TAB 5, Location Index 4
                                          locations4.isNotEmpty
                                              ? GridView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisExtent: 224,
                                                  ),
                                                  shrinkWrap: true,
                                                  itemCount: locations4.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final listData =
                                                        locations4[index];
                                                    return InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                HistoryCubit>()
                                                            .addHistory(
                                                                listData);
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
                                                            listData.imageUrl!,
                                                        title:
                                                            listData.postTitle,
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
                                                        height: height * 0.15,
                                                      ),
                                                      Text(
                                                        "Tidak ada Kajian",
                                                        style:
                                                            GoogleFonts.outfit(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                          color: blackTextColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          //TAB 6, Location 5
                                          locations5.isNotEmpty
                                              ? GridView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisExtent: 224,
                                                  ),
                                                  shrinkWrap: true,
                                                  itemCount: locations5.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final listData =
                                                        locations5[index];
                                                    return InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                HistoryCubit>()
                                                            .addHistory(
                                                                listData);
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
                                                            listData.imageUrl!,
                                                        title:
                                                            listData.postTitle,
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
                                                        height: height * 0.15,
                                                      ),
                                                      Text(
                                                        "Tidak ada Kajian",
                                                        style:
                                                            GoogleFonts.outfit(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                          color: blackTextColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        ],
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
                      }
                      if (userState is UserDetailErrorState) {
                        //if user logged in with google, user data will not yet available except
                        //if user updated profile data, so to handle that, this condition is used
                        final googleLoginStatus = preferencesUtils
                                .getPreferencesBool("googleLogin") ??
                            false;
                        if (googleLoginStatus) {
                          String currentUserLocation =
                              "Semarang"; //default set as semarang
                          List<String> locations = [
                            "Semarang",
                            "Jepara",
                            "Demak",
                            "Pekalongan",
                            "Purwokerto",
                            "Solo"
                          ];

                          locations.remove(currentUserLocation);

                          return SizedBox(
                            width: width,
                            height: height * 0.77,
                            child: DefaultTabController(
                              length: 6,
                              child: Scaffold(
                                body: BlocBuilder<DashboardJamaahCubit,
                                    DashboardJamaahState>(
                                  builder: (context, state) {
                                    if (state is DashboardJamaahLoadingState) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (state is DashboardJamaahErrorState) {
                                      return Text(
                                          "error : ${state.errorMessage}");
                                    }
                                    if (state is DashboardJamaahSuccessState) {
                                      List<OfflineEvent> closestLocation = state
                                          .offlineEventResponse
                                          .where((event) =>
                                              event.location ==
                                              currentUserLocation)
                                          .toList();
                                      List<OfflineEvent> locations1 = state
                                          .offlineEventResponse
                                          .where((event) =>
                                              event.location == locations[0])
                                          .toList();
                                      List<OfflineEvent> locations2 = state
                                          .offlineEventResponse
                                          .where((event) =>
                                              event.location == locations[1])
                                          .toList();
                                      List<OfflineEvent> locations3 = state
                                          .offlineEventResponse
                                          .where((event) =>
                                              event.location == locations[2])
                                          .toList();
                                      List<OfflineEvent> locations4 = state
                                          .offlineEventResponse
                                          .where((event) =>
                                              event.location == locations[3])
                                          .toList();
                                      List<OfflineEvent> locations5 = state
                                          .offlineEventResponse
                                          .where((event) =>
                                              event.location == locations[4])
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
                                          tabs: [
                                            Tab(
                                              child: Text(
                                                currentUserLocation,
                                                style: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Tab(
                                              child: Text(
                                                locations[0],
                                                style: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Tab(
                                              child: Text(
                                                locations[1],
                                                style: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Tab(
                                              child: Text(
                                                locations[2],
                                                style: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Tab(
                                              child: Text(
                                                locations[3],
                                                style: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Tab(
                                              child: Text(
                                                locations[4],
                                                style: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        body: TabBarView(
                                          children: [
                                            //TAB 1, Closest Location
                                            closestLocation.isNotEmpty
                                                ? GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 224,
                                                    ),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        closestLocation.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final listData =
                                                          closestLocation[
                                                              index];
                                                      return InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                  HistoryCubit>()
                                                              .addHistory(
                                                                  listData);
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
                                                          height: height * 0.15,
                                                        ),
                                                        Text(
                                                          "Tidak ada Kajian",
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
                                            //TAB 2, Location 1
                                            locations1.isNotEmpty
                                                ? GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 224,
                                                    ),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        locations1.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final listData =
                                                          locations1[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                  HistoryCubit>()
                                                              .addHistory(
                                                                  listData);
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
                                                          height: height * 0.15,
                                                        ),
                                                        Text(
                                                          "Tidak ada Kajian",
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
                                            //TAB 3, Location 2
                                            locations2.isNotEmpty
                                                ? GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 224,
                                                    ),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        locations2.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final listData =
                                                          locations2[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                  HistoryCubit>()
                                                              .addHistory(
                                                                  listData);
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
                                                          height: height * 0.15,
                                                        ),
                                                        Text(
                                                          "Tidak ada Kajian",
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
                                            //TAB 4, Location 3
                                            locations3.isNotEmpty
                                                ? GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 224,
                                                    ),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        locations3.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final listData =
                                                          locations3[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                  HistoryCubit>()
                                                              .addHistory(
                                                                  listData);
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
                                                          height: height * 0.15,
                                                        ),
                                                        Text(
                                                          "Tidak ada Kajian",
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
                                            //TAB 5, Location Index 4
                                            locations4.isNotEmpty
                                                ? GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 224,
                                                    ),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        locations4.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final listData =
                                                          locations4[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                  HistoryCubit>()
                                                              .addHistory(
                                                                  listData);
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
                                                          height: height * 0.15,
                                                        ),
                                                        Text(
                                                          "Tidak ada Kajian",
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
                                            //TAB 6, Location 5
                                            locations5.isNotEmpty
                                                ? GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 224,
                                                    ),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        locations5.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final listData =
                                                          locations5[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                  HistoryCubit>()
                                                              .addHistory(
                                                                  listData);
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
                                                          height: height * 0.15,
                                                        ),
                                                        Text(
                                                          "Tidak ada Kajian",
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
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.only(
                              top: 128,
                            ),
                            child: Text(
                              "error : ${userState.errorMessage}",
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: blackTextColor,
                              ),
                            ),
                          ));
                        }
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbarComponent(),
    );
  }
}
