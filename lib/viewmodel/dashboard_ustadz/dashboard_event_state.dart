import 'package:equatable/equatable.dart';
import 'package:kajian_fikih/model/offline_event.dart';

class DashboardEventState extends Equatable {
  const DashboardEventState();

  @override
  List<Object?> get props => [];
}

class DashboardEventInitialState extends DashboardEventState {}

class DashboardEventLoadingState extends DashboardEventState {}

class DashboardEventSuccessState extends DashboardEventState {
  final List<OfflineEvent> offlineEventResponse;

  const DashboardEventSuccessState(this.offlineEventResponse);

  @override
  List<Object> get props => [offlineEventResponse];
}

class DashboardEventErrorState extends DashboardEventState {
  final String errorMessage;

  const DashboardEventErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
