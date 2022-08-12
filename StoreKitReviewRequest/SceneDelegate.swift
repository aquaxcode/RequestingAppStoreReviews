/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The scene delegate.
*/

import UIKit
import StoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property automatically initializes and attaches to the scene.
        // This delegate doesn't imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the system releases the scene.
        // This occurs shortly after the scene enters the background, or when the system discards its session.
        // Release any resources associated with this scene that the system can re-create the next time the scene connects.
        // The scene may reconnect later because the system doesn’t necessarily discard its session
        // (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene moves from an inactive state to an active state.
        // Use this method to restart any tasks that the system pauses (or doesn’t start) when the scene is inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene is about to move from an active state to an inactive state.
        // This may occur due to temporary interruptions (such as an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes the system makes on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene to its current state.
    }
}
