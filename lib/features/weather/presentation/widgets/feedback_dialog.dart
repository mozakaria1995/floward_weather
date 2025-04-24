import 'package:floward_weather/core/utils/injection_container.dart';
import 'package:floward_weather/core/utils/strings.dart';
import 'package:floward_weather/core/utils/theme.dart';
import 'package:floward_weather/features/weather/data/services/feedback_service.dart';
import 'package:flutter/material.dart';

class FeedbackDialog extends StatelessWidget {
  final TextEditingController controller;

  const FeedbackDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FeedbackService feedbackService = sl<FeedbackService>();

    return AlertDialog(
      backgroundColor: AppTheme.primaryDark,
      title: const Text(
        AppStrings.feedbackTitle,
        style: TextStyle(color: Colors.white),
      ),
      content: TextField(
        controller: controller,
        maxLines: 4,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: AppStrings.feedbackHint,
          hintStyle: TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            AppStrings.cancel,
            style: TextStyle(color: Colors.white70),
          ),
        ),
        ElevatedButton(
          onPressed: () => _submitFeedback(
            context,
            controller,
            feedbackService,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppTheme.primaryDark,
          ),
          child: const Text(AppStrings.send),
        ),
      ],
    );
  }

  void _submitFeedback(
    BuildContext context,
    TextEditingController controller,
    FeedbackService feedbackService,
  ) async {
    final feedbackText = controller.text.trim();
    if (feedbackText.isEmpty) {
      return;
    }

    final String savedFeedbackText = feedbackText;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.primaryDark,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );

    try {
      final success = await feedbackService.submitFeedback(savedFeedbackText);

      if (!context.mounted) return;
      Navigator.pop(context);

      if (!context.mounted) return;
      Navigator.pop(context);

      if (!context.mounted) return;

      if (success) {
        final platform = Theme.of(context).platform;
        final platformName = platform == TargetPlatform.iOS ? 'iOS' : 'Android';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${AppStrings.thankYouFeedback} Processed by $platformName native code.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to submit feedback. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
