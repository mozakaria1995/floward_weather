import 'package:floward_weather/features/profile/data/datasources/profile_datasource.dart';
import 'package:floward_weather/features/profile/data/models/profile_model.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  @override
  Future<ProfileModel> getProfile() async {
    // Simulating network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Return mock profile data
    return const ProfileModel(
      name: 'Mohamed Zakaria',
      email: 'mo.zakaria95@gmail.com',
      location: 'Cairo, Egypt',
      memberSince: 'January 2023',
      avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
    );
  }
}
