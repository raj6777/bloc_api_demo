import '../../model/UserModel.dart'; // Replace with Datum model if necessary

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Datum user;

  ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);

  @override
  List<Object?> get props => [error];
}
