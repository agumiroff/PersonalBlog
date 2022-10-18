import 'package:bloc/bloc.dart';

abstract class MyAuthorsEvents {}

abstract class MyAuthorsStates {}

class MyAuthorsStartState extends MyAuthorsStates {}

class MyAuthorsBloc extends Bloc<MyAuthorsEvents, MyAuthorsStates> {
  MyAuthorsBloc() : super(MyAuthorsStartState());
}
