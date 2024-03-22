import FirebaseAnalytics

final class AnalyticsManager {
    static func logEvent(_ event: String, parameters: [String: Any]? = nil) {
        Analytics.logEvent(event, parameters: parameters)
    }
}
