import 'package:equatable/equatable.dart';
import 'package:kajian_fikih/model/offline_event.dart';

class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryInitialState extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistorySuccessState extends HistoryState {
  final List<OfflineEvent> offlineEventHistory;

  const HistorySuccessState(this.offlineEventHistory);

  @override
  List<Object> get props => [offlineEventHistory];
}

class HistoryErrorState extends HistoryState {
  final String errorMessage;

  const HistoryErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
