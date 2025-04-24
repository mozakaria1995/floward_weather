import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller = window?.rootViewController as! FlutterViewController
    
    // Set up method channel for profile feature
    let profileChannel = FlutterMethodChannel(name: "com.floward.weather/profile", 
                                             binaryMessenger: controller.binaryMessenger)
    
    profileChannel.setMethodCallHandler { [weak self] (call, result) in
      if call.method == "getProfileData" {
        // Return mock profile data
        let profileData: [String: Any] = [
          "name": "Mohamed Zakaria",
          "email": "mo.zakaria95@gmail.com",
          "location": "Cairo, Egypt",
          "member_since": "January 2023",
          "avatar_url": "https://randomuser.me/api/portraits/men/32.jpg",
          "os": "iOS"
        ]
        
        // Log profile data before sending
        NSLog("Sending profile data: \(profileData)")
        
        // Send the result
        result(profileData)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    
    // Set up method channel for feedback feature
    let feedbackChannel = FlutterMethodChannel(name: "com.floward.weather/feedback", 
                                             binaryMessenger: controller.binaryMessenger)
    
    feedbackChannel.setMethodCallHandler { [weak self] (call, result) in
      if call.method == "submitFeedback" {
        guard let args = call.arguments as? [String: Any],
              let feedback = args["feedback"] as? String else {
          result(FlutterError(code: "INVALID_ARGUMENTS", 
                              message: "Missing feedback data", 
                              details: nil))
          return
        }
        
        // Log received feedback
        NSLog("Received feedback from Flutter: \(feedback)")
        
        // In a real app, you would process the feedback here
        // For example, save it to a local database or send it to a server
        
        // Simulate processing delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          // Return success
          result(true)
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
