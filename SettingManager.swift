import Foundation

struct QuizSettings: Codable {
    var categories: [String: CategorySettings]
}

class SettingsManager {

    static let shared = SettingsManager()
    private let key = "quiz_settings"

    var settings: QuizSettings {
        get {
            if let data = UserDefaults.standard.data(forKey: key),
               let decoded = try? JSONDecoder().decode(QuizSettings.self, from: data) {
                return decoded
            }

            return QuizSettings(
                categories: [
                    "statistics": CategorySettings(enabled: true, dailyCount: 1),
                    "ml": CategorySettings(enabled: true, dailyCount: 1),
                    "swe": CategorySettings(enabled: true, dailyCount: 1),
                    "quant": CategorySettings(enabled: true, dailyCount: 1)
                ]
            )
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func resetToDefaults() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
