/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A class that provides keys for user defaults in this sample.
*/

class UserDefaultsKeys {
    
    // An identifier for the three-step process the user completes
    // before this app chooses to request a review.
    class var processCompletedCountKey: String {
        return "processCompletedCount"
    }
    
    class var lastVersionPromptedForReviewKey: String {
        return "lastVersionPromptedForReview"
    }
    
}
