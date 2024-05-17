import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/model/offline_event.dart';
import 'package:kajian_fikih/viewmodel/dashboard_jamaah/dashboard_jamaah_state.dart';

class DashboardJamaahCubit extends Cubit<DashboardJamaahState> {
  DashboardJamaahCubit() : super(DashboardJamaahInitialState());

  Future getOfflinePost() async {
    emit(DashboardJamaahLoadingState());
    try {
      List<OfflineEvent> events = [];
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final eventsCollection =
            FirebaseFirestore.instance.collection('events');
        final snapshot = await eventsCollection.get();
        for (var doc in snapshot.docs) {
          events.add(OfflineEvent.fromFirestore(doc.data()));
        }
        emit(DashboardJamaahSuccessState(events));
      } else {
        emit(const DashboardJamaahErrorState("403 - Unauthorized"));
      }
    } catch (e) {
      emit(DashboardJamaahErrorState(e.toString()));
    }
  }
}
