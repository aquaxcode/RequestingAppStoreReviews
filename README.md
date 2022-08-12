# Requesting App Store reviews

Implement best practices for prompting users to leave a review for your app in the App Store. 

## Overview

Presenting your users with a request for an App Store review using [`SKStoreReviewController`](https://developer.apple.com/documentation/storekit/skstorereviewcontroller) is a good way to get feedback on your app. However, be aware that the system displays the prompt to a user a maximum of three times within a 365-day period. You can determine when and where your app displays the prompt to request a review.
Think about the best places within your app to show a request for review, and what conditions are appropriate to delay it. Here are some best practices:

* Try to make the request at a time that doesn't interrupt what the user is trying to achieve in your app. For example, at the end of a sequence of events that the user successfully completes.
* Avoid showing a request for a review immediately when a user launches your app, even if it isn't the first time that it launches.
* Avoid requesting a review as the result of a user action.

Also remember that the user can disable requests for reviews from *ever* appearing on their device.


## Present the review request
This sample project consists of a simulated three-step process. The user taps the Start Process button, and then taps Continue Process twice, after which the app presents a Process Completed view controller scene. The request for review appears to the user from this scene only.

In addition, the app meets the following conditions before displaying the prompt:

* The app hasn't shown a review prompt for a version of the app bundle that matches the current bundle version. This ensures that the user doesn't receive a prompt to review the same version of an app multiple times.
* The user successfully completes the three-step process at least four times. This number is arbitrary and developers can choose something that fits well with how many times the user is likely to complete a process in their apps.
* The user must pause on the Process Completed scene for a few seconds. This requirement limits the possibility of the prompt interrupting the user before they move to a different task in the app.

The conditions above exist purely to delay the call to [`requestReview(in:)`](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/3566727-requestreview), and so days, weeks, or potentially even months can elapse without the app prompting a user for a review. Techniques to delay the call are valuable because they cause an app to show a review request to more experienced users that are getting real value from using it.


In the following code sample, the app stores the usage data that delays the review request in [`UserDefaults`](https://developer.apple.com/documentation/foundation/userdefaults). In other apps, there may be more appropriate on-device storage options. For more information about best practices for requesting reviews, see [Human Interface Guidelines > Ratings and reviews](https://developer.apple.com/ios/human-interface-guidelines/system-capabilities/ratings-and-reviews/).
``` swift
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
```
[View in Source](x-source-tag://RequestReview)



## Manually request a review

To enable a user to initiate a review as a result of an action in the UI, the sample code uses a deep link to the App Store page for the app with the query parameter `action=write-review` appended to the URL.

``` swift
@IBAction func requestReviewManually() {
    // Note: Replace the placeholder value below with the App Store ID for your app.
    //       You can find the App Store ID in your app's product URL.
    guard let writeReviewURL = URL(string: "https://apps.apple.com/app/id<#Your App Store ID#>?action=write-review")
        else { fatalError("Expected a valid URL") }
    UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
}
```
[View in Source](x-source-tag://ManualReviewRequest)
