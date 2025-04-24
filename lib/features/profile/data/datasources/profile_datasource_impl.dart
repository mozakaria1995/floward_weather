import 'package:floward_weather/features/profile/data/models/profile_model.dart';
import 'package:flutter/services.dart';

import 'profile_datasource.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  final MethodChannel _channel;

  ProfileDataSourceImpl({MethodChannel? channel})
      : _channel =
            channel ?? const MethodChannel('com.floward.weather/profile');

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final Map<String, dynamic> userData =
          await _channel.invokeMapMethod<String, dynamic>('getProfileData') ??
              {};

      return ProfileModel.fromJson(userData);
    } on PlatformException catch (e) {
      throw PlatformException(
        code: 'profile_error',
        message: 'Failed to get profile data',
        details: e.toString(),
      );
    }
  }
}
