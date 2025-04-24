import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Set up method channel for profile feature
    let controller = window?.rootViewController as! FlutterViewController
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
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
