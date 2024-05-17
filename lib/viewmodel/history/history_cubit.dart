import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/model/offline_event.dart';
import 'package:kajian_fikih/viewmodel/history/history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitialState());

  Future getLatestHistory() async {
    emit(HistoryLoadingState());
    try {
      List<OfflineEvent> events = [];
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final historyCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(currentUser.uid)
            .collection('history');
        final historyData = await historyCollection.limit(5).get();
        for (var event in historyData.docs) {
          events.add(OfflineEvent.fromFirestore(event.data()));
        }
        emit(HistorySuccessState(events));
      } else {
        emit(const HistoryErrorState("403 - Unauthorized"));
      }
    } catch (e) {
      emit(HistoryErrorState(e.toString()));
    }
  }

  Future addHistory(OfflineEvent event) async {
    emit(HistoryLoadingState());
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final historyCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(currentUser.uid)
            .collection('history');

        await historyCollection.doc(event.docId).set(event.toFirestore());
      } else {
        emit(const HistoryErrorState("403 - Unauthorized"));
      }
    } catch (e) {
      emit(HistoryErrorState(e.toString()));
    }
  }
}
