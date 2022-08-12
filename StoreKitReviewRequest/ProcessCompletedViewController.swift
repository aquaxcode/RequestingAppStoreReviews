/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The Process Completed view controller scene.
*/

import UIKit
import StoreKit

class ProcessCompletedViewController: UIViewController {

    // MARK: View life cycle

    /// - Tag: RequestReview
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If the app doesn't store the count, this returns 0.
        var count = UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCountKey)
        count += 1
        UserDefaults.standard.set(count, forKey: UserDefaultsKeys.processCompletedCountKey)
        print("Process completed \(count) time(s).")
        
        // Keep track of the most recent app version that prompts the user for a review.
        let lastVersionPromptedForReview = UserDefaults.standard.string(forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey)

        // Get the current bundle version for the app.
        let infoDictionaryKey = kCFBundleVersionKey as String
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
            else { fatalError("Expected to find a bundle version in the info dictionary.") }
         // Verify the user completes the process several times and doesn’t receive a prompt for this app version.
         if count >= 4 && currentVersion != lastVersionPromptedForReview {
             Task { @MainActor [weak self] in
                 // Delay for two seconds to avoid interrupting the person using the app.
                 // Use the equation n * 10^9 to convert seconds to nanoseconds.
                 try? await Task.sleep(nanoseconds: UInt64(2e9))
                 if let windowScene = self?.view.window?.windowScene,
                    self?.navigationController?.topViewController is ProcessCompletedViewController {
                     SKStoreReviewController.requestReview(in: windowScene)
                     UserDefaults.standard.set(currentVersion, forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey)
                }
             }
         }

    }

    // MARK: Action methods

    @IBAction func done() {
        navigationController?.popToRootViewController(animated: true)
    }
}
