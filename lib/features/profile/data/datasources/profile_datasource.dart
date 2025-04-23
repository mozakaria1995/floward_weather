import 'package:floward_weather/features/profile/data/models/profile_model.dart';

abstract class ProfileDataSource {
  Future<ProfileModel> getProfile();
}
