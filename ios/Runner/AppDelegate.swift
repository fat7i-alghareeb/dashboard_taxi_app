import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let rawMapKey = (Bundle.main.object(forInfoDictionaryKey: "GoogleMapsApiKey") as? String) ?? ""
    let mapKey = rawMapKey.trimmingCharacters(in: .whitespacesAndNewlines)

    if mapKey.isEmpty || mapKey == "{apiKey}" {
      NSLog("[MapsConfig] WARNING: GoogleMapsApiKey is missing or placeholder. Map tiles will not load.")
    } else {
      GMSServices.provideAPIKey(mapKey)
      let suffix = mapKey.count > 6 ? String(mapKey.suffix(6)) : "short"
      NSLog("[MapsConfig] Google Maps key loaded (***%@)", suffix)
    }

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
