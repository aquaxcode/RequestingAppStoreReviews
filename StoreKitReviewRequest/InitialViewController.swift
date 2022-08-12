/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The initial view controller scene.
*/

import UIKit

class InitialViewController: UIViewController {
    
    // MARK: Action methods
    
    @IBAction func resetChecks() {
        // Reset the run counter and the most recently checked bundle version.
        UserDefaults.standard.set(0, forKey: UserDefaultsKeys.processCompletedCountKey)
        UserDefaults.standard.set("", forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey)
        print("All checks have been reset")
    }
    
    /// - Tag: ManualReviewRequest
    @IBAction func requestReviewManually() {
        // Note: Replace the placeholder value below with the App Store ID for your app.
        //       You can find the App Store ID in your app's product URL.
        guard let writeReviewURL = URL(string: "https://apps.apple.com/app/id<#Your App Store ID#>?action=write-review")
            else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
}
