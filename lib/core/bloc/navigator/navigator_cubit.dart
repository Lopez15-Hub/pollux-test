import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class NavigatorCubit extends Cubit {
  NavigatorCubit() : super(null);

  pushWidget(BuildContext context, Widget widget) {
    final route = MaterialPageRoute(builder: (context) => widget);
    Navigator.of(context).push(route);
  }

  pop(BuildContext context) => Navigator.pop(context);
}
