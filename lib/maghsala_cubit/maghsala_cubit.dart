import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maghsala/maghsala_cubit/maghsala_states.dart';

import '../contact_screen.dart';
import '../pickingup_screen.dart';
import '../member_ship_screen.dart';
import '../settings_screen.dart';


class maghsala_cubit extends Cubit<MaghsalaState> {
  maghsala_cubit() : super(MaghsalaInitialState());
  static maghsala_cubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const pickingUpScreen(),
    const MemberShipScreen(),
    const contactScreen(),
    const SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(MaghsalaChangeBottomNavState());
  }
}
