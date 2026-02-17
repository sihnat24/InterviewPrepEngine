import Foundation
import UserNotifications

class NotificationManager {

    static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound]
        ) { granted, _ in
            print("Notifications granted:", granted)
        }
    }
}


extension NotificationManager {

    func scheduleDaily(hour: Int = 11) {
        let content = UNMutableNotificationContent()
        content.title = "🧠 Daily Coding Quiz"
        content.body = "Want a 30-second coding flashcard?"
        content.sound = .default

        var date = DateComponents()
        date.hour = hour

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: date,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: "daily_quiz",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }
}
