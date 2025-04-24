import 'package:floward_weather/core/utils/strings.dart';
import 'package:floward_weather/core/utils/styles.dart';
import 'package:floward_weather/core/utils/theme.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:floward_weather/features/weather/presentation/bloc/weather_state.dart';
import 'package:floward_weather/features/weather/presentation/widgets/feedback_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherLoaded) {
            return WeatherContent(
              weather: state.weather,
              animationPath: state.animationPath,
            );
          } else if (state is WeatherError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppStyles.errorColor,
                    size: AppStyles.largeIconSize,
                  ),
                  const SizedBox(height: AppStyles.largeSpace),
                  Text(
                    state.message,
                    style: AppStyles.errorMessageStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text(AppStrings.checkWeather),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showFeedbackDialog(context),
        backgroundColor: AppTheme.primaryDark,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.feedback_outlined),
        label: const Text(AppStrings.submitFeedback),
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => FeedbackDialog(
        controller: controller,
      ),
    ).then((_) {
      controller.dispose();
    });
  }
}

class WeatherContent extends StatelessWidget {
  final dynamic weather;
  final String animationPath;

  const WeatherContent({
    Key? key,
    required this.weather,
    required this.animationPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppTheme.weatherBackgroundGradient,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: AppStyles.extraLargeSpace),
                _buildWeatherInfo(),
                const SizedBox(height: AppStyles.extraLargeSpace),
                _buildTemperature(),
                const SizedBox(height: AppStyles.extraLargeSpace),
                _buildExtraInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: AppStyles.cityNameStyle,
        ),
        const SizedBox(height: AppStyles.mediumSpace),
        Text(
          DateFormat(AppStrings.dateFormat).format(DateTime.now()),
          style: AppStyles.dateStyle,
        ),
      ],
    );
  }

  Widget _buildWeatherInfo() {
    return Column(
      children: [
        Lottie.asset(
          animationPath,
          width: 150,
          height: 150,
        ),
        const SizedBox(height: AppStyles.mediumSpace),
        Text(
          weather.condition,
          style: AppStyles.conditionStyle,
        ),
      ],
    );
  }

  Widget _buildTemperature() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${weather.temperature.round()}${AppStrings.celsius}',
          style: AppStyles.temperatureStyle,
        ),
      ],
    );
  }

  Widget _buildExtraInfo() {
    return Container(
      margin: AppStyles.cardMargin,
      padding: AppStyles.cardPadding,
      decoration: BoxDecoration(
        color: AppStyles.textColor.withAlpha(51),
        borderRadius: BorderRadius.circular(AppStyles.cardBorderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildExtraInfoItem(
            AppStrings.wind,
            '${weather.windSpeed} ${AppStrings.kmh}',
            Icons.air,
          ),
          _buildExtraInfoItem(
            AppStrings.humidity,
            '${weather.humidity}${AppStrings.percentSign}',
            Icons.water_drop,
          ),
          _buildExtraInfoItem(
            AppStrings.feelsLike,
            '${weather.feelsLike.round()}${AppStrings.celsius}',
            Icons.thermostat,
          ),
        ],
      ),
    );
  }

  Widget _buildExtraInfoItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppStyles.textColor,
          size: AppStyles.smallIconSize,
        ),
        const SizedBox(height: AppStyles.smallSpace),
        Text(
          title,
          style: AppStyles.infoTitleStyle,
        ),
        const SizedBox(height: AppStyles.smallSpace / 2),
        Text(
          value,
          style: AppStyles.infoValueStyle,
        ),
      ],
    );
  }
}
