part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({required this.user});

  final UserEntity user;

  @override
  List<Object> get props => [user];
}
