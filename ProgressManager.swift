import Foundation

class ProgressManager {

    static let shared = ProgressManager()
    private let key = "category_progress"

    private var progress: [String: CategoryProgress] {
        get {
            if let data = UserDefaults.standard.data(forKey: key),
               let decoded = try? JSONDecoder().decode([String: CategoryProgress].self, from: data) {
                return decoded
            }
            return [:]
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func record(category: String, confident: Bool) {
        var p = progress[category] ?? CategoryProgress(
            timesSeen: 0,
            timesConfident: 0,
            lastSeen: Date()
        )

        p.timesSeen += 1
        if confident {
            p.timesConfident += 1
        }
        p.lastSeen = Date()

        progress[category] = p
    }

    func stats() -> [String: CategoryProgress] {
        progress
    }
}
