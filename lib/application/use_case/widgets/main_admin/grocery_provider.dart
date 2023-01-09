import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:system_delivery/application/use_case/widgets/main_admin/frm_main_admin_bloc.dart';

class GroceryProvider extends InheritedWidget {
  final GroceryStoreBloc bloc;
  final Widget child;

  GroceryProvider({required this.bloc, required this.child})
      : super(child: child);

  static GroceryProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<GroceryProvider>();
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
