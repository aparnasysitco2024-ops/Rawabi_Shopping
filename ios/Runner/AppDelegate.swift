import UIKit
import Flutter
import GoogleMaps
import Firebase 

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    GMSServices.provideAPIKey("AIzaSyA-4hm6OP4VY9_Lr_LkxLpGDvlUvLFKV8I")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
