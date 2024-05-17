import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/model/offline_event.dart';
import 'package:kajian_fikih/viewmodel/dashboard_ustadz/dashboard_event_state.dart';

class DashboardEventCubit extends Cubit<DashboardEventState> {
  DashboardEventCubit() : super(DashboardEventInitialState());

  Future getUserEventsForToday(String userId) async {
    emit(DashboardEventLoadingState());
    try {
      List<OfflineEvent> eventsList = [];
      // Get current date
      DateTime now = DateTime.now();
      String formattedDate =
          "${now.day} ${getMonthName(now.month)} ${now.year}";

      // Query Firestore for user events with today's date
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(userId)
          .collection('events')
          .where('date', isEqualTo: formattedDate)
          .get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        OfflineEvent events = OfflineEvent.fromFirestore(data);
        eventsList.add(events);
      }

      emit(DashboardEventSuccessState(eventsList));
    } catch (e) {
      emit(DashboardEventErrorState(e.toString()));
    }
  }

  Future getUserEventsByDate(String userId, DateTime date) async {
    emit(DashboardEventLoadingState());
    try {
      List<OfflineEvent> eventsList = [];
      // Get current date
      String formattedDate =
          "${date.day} ${getMonthName(date.month)} ${date.year}";

      // Query Firestore for user events with today's date
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(userId)
          .collection('events')
          .where('date', isEqualTo: formattedDate)
          .get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        OfflineEvent events = OfflineEvent.fromFirestore(data);
        eventsList.add(events);
      }

      emit(DashboardEventSuccessState(eventsList));
    } catch (e) {
      emit(DashboardEventErrorState(e.toString()));
    }
  }

  Future getUserEventsForDateRange(
    String userId,
    int daysAfter,
  ) async {
    // Calculate the date range
    List<OfflineEvent> eventsList = [];
    try {
      DateTime now = DateTime.now();
      DateTime endDate =
          DateTime(now.year, now.month, now.day + daysAfter, 23, 59, 59);

      // Format the end date
      String formattedEndDate =
          '${endDate.day} ${getMonthName(endDate.month)} ${endDate.year}';

      // Query Firestore for user events within the date range
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(userId)
          .collection('events')
          .where('date', isLessThanOrEqualTo: formattedEndDate)
          .limit(7)
          .get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        OfflineEvent events = OfflineEvent.fromFirestore(data);
        eventsList.add(events);
      }

      emit(DashboardEventSuccessState(eventsList));
    } catch (e) {
      emit(DashboardEventErrorState(e.toString()));
    }
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }
}
