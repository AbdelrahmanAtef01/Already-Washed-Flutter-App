import 'package:meta/meta.dart';

@immutable
abstract class AppState {}

class AppInitialState extends AppState {}

class SocialCreateUserSuccessState extends AppState {}

class SocialCreateUserErrorState extends AppState
{
  final String error;

  SocialCreateUserErrorState(this.error);
}

class SocialRegisterInitialState extends AppState {}

class SocialRegisterLoadingState extends AppState {}

class SocialRegisterSuccessState extends AppState {}

class SocialRegisterErrorState extends AppState
{
  final String error;

  SocialRegisterErrorState(this.error);
}