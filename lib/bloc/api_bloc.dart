import 'package:api_calling_bloc_mvvm_demo/model/NewsModel.dart';
import 'package:bloc/bloc.dart';
import '../model/UserModel.dart';
import '../repository/user_repository.dart';
import 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final UserRepository userRepository;
  ApiBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUser>((event, emit) async{
      emit(UserLoadig());
       try {
          final users = await userRepository.fetchUsers();
          emit(UserLoaded(users));
        }catch(e){
         emit(UserError("Failed to fetch users: $e")); //
       }
    });
    on<FetchNews>((event, emit) async{
      emit(UserLoadig());
      try {
        final news = await userRepository.fetchTopHeadlines();
        emit(NewsLoaded(news));
      }catch(e){
        emit(UserError("Failed to fetch users: $e")); //
      }

    });



  }
}
