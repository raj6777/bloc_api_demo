import 'package:api_calling_bloc_mvvm_demo/model/NewsModel.dart';
import 'package:bloc/bloc.dart';
import '../../model/UserModel.dart';
import '../../repository/user_repository.dart';
import 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUser>((event, emit) async {
      emit(UserLoadig());
      try {
        final users = await userRepository.fetchUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError("Failed to fetch users: $e")); //
      }
    });
  }
}
