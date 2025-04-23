import 'package:floward_weather/features/profile/domain/usecases/get_profile.dart';
import 'package:floward_weather/features/profile/presentation/bloc/profile_event.dart';
import 'package:floward_weather/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;

  ProfileBloc({required this.getProfile}) : super(const ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    final result = await getProfile(const NoParams());
    result.fold(
      (failure) => emit(ProfileError(message: failure.toString())),
      (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }
}
