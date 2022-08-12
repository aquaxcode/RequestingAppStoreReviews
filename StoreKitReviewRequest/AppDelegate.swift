/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The app delegate.
*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    // MARK: UISceneSession life cycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
         // Called when creating a new scene session.
        // Use this method to select a configuration to create the new scene.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If the system discards any sessions while the app isn't running, it calls this shortly
        // after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that are specific to the discarded scenes,
        // because they don't return.
    }

}
