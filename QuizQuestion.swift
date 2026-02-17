import Foundation

struct QuizQuestion: Identifiable, Codable {
    let id: String            // ← comes from JSON
    let category: String
    let prompt: String
    let answer: String
    let hint: String?
    let explanation: String

    // Learning state (NOT in JSON)
    var priority: Double = 1.0
    var lastSeen: Date? = nil
}
