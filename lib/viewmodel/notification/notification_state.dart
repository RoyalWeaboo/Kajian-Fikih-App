import 'package:equatable/equatable.dart';
import 'package:kajian_fikih/model/post_notification.dart';

class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitialState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationSuccessState extends NotificationState {
  final List<PostNotification> postNotificationResponse;

  const NotificationSuccessState(this.postNotificationResponse);

  @override
  List<Object> get props => [postNotificationResponse];
}

class NotificationErrorState extends NotificationState {
  final String errorMessage;

  const NotificationErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
