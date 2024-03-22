import UserNotifications

enum NotificationManager {
    static func scheduleDailyNotification(title: String, body: String, identifier: String) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        
        var dateComponents = DateComponents()
        dateComponents.hour = 21
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                NSLog("Error: \(error)")
            }
        }
    }
    
    static func receivePushNotiNews(title: String, body: String, liknURL: String) {
        let newsText = "\(title) : \(body) | \(liknURL)"
        var newsList = UserDefaults.standard.stringArray(forKey: "NewsList") ?? []
        newsList.append(newsText)
        UserDefaults.standard.set(newsList, forKey: "NewsList")
    }
}
