import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());
}

abstract class UsersState {}

class UsersInitial extends UsersState {}
