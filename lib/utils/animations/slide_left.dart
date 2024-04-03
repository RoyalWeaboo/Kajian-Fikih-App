import 'package:flutter/material.dart';

class SlideLeftAnimation extends PageRouteBuilder {
  final Widget page;
  dynamic arguments;

  SlideLeftAnimation({required this.page, this.arguments})
      : super(
          settings: arguments != null
              ? RouteSettings(arguments: arguments)
              : const RouteSettings(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return page;
          },
        );
}
