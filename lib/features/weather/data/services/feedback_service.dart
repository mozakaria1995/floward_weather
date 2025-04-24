import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FeedbackService {
  static const String channelName = 'com.floward.weather/feedback';
  static const String submitFeedbackMethod = 'submitFeedback';

  final MethodChannel _channel;

  FeedbackService({MethodChannel? channel})
      : _channel = channel ?? const MethodChannel(channelName);

  /// Submit feedback to native platforms
  Future<bool> submitFeedback(String feedback) async {
    try {
      // Log the feedback for debugging purposes
      if (kDebugMode) {
        print('Sending feedback to native: $feedback');
      }

      // Send feedback to native through method channel
      final result = await _channel
          .invokeMethod<bool>(submitFeedbackMethod, {'feedback': feedback});

      // Return result, defaulting to false if null
      return result ?? false;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to send feedback to native: ${e.message}');
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Error sending feedback: $e');
      }
      return false;
    }
  }
}
