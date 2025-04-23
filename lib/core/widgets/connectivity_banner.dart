import 'package:floward_weather/core/utils/strings.dart';
import 'package:floward_weather/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ConnectivityBanner extends StatelessWidget {
  final bool isConnected;
  final VoidCallback? onRetry;

  const ConnectivityBanner({
    Key? key,
    required this.isConnected,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isConnected) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      color: AppStyles.errorColor,
      padding: const EdgeInsets.symmetric(
        vertical: AppStyles.smallSpace,
        horizontal: AppStyles.largeSpace,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            const Icon(
              Icons.wifi_off,
              color: AppStyles.textColor,
              size: AppStyles.smallIconSize,
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            const Expanded(
              child: Text(
                AppStrings.noInternetConnection,
                style: TextStyle(
                  color: AppStyles.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (onRetry != null)
              TextButton(
                onPressed: onRetry,
                style: TextButton.styleFrom(
                  foregroundColor: AppStyles.textColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppStyles.smallSpace),
                ),
                child: const Text(AppStrings.retry),
              ),
          ],
        ),
      ),
    );
  }
}
