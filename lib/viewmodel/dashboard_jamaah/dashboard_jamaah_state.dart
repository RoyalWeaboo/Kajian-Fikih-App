import 'package:equatable/equatable.dart';
import 'package:kajian_fikih/model/offline_event.dart';

class DashboardJamaahState extends Equatable {
  const DashboardJamaahState();

  @override
  List<Object> get props => [];
}

class DashboardJamaahInitialState extends DashboardJamaahState {}

class DashboardJamaahLoadingState extends DashboardJamaahState {}

class DashboardJamaahSuccessState extends DashboardJamaahState {
  final List<OfflineEvent> offlineEventResponse;

  const DashboardJamaahSuccessState(this.offlineEventResponse);

  @override
  List<Object> get props => [offlineEventResponse];
}

class DashboardJamaahErrorState extends DashboardJamaahState {
  final String errorMessage;

  const DashboardJamaahErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
