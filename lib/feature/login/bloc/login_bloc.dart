import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/feature/login/bloc/login_event.dart';
import 'package:flutter_bloc_demo/feature/login/bloc/login_state.dart';
import 'package:flutter_bloc_demo/feature/login/repo/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc({required this.repository}) : super(Initial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    yield Loading();
    if (event is LoginCallEvent) {
      final data = await repository.performLogin(event.email, event.password);
      yield data.fold(
        (failure) => Error(message: failure.message),
        (r) => LoginSuccessfulState(r),
      );
    }
  }
}
