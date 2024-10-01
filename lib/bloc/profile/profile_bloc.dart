import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';
import '../../model/UserModel.dart'; // Replace with Datum model if necessary
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfileEvent>(_onFetchProfile);
  }

  Future<void> _onFetchProfile(
      FetchProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    try {
      final store = objectbox.store;
      final datumBox = store.box<Datum>();

      final allData = datumBox.getAll();
      if (allData.isNotEmpty) {
        final user = allData.first;
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError("No user found"));
      }
    } catch (e) {
      emit(ProfileError("Failed to fetch user data: $e"));
    }
  }
}
