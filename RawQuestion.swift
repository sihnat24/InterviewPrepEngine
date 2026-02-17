import Foundation

struct RawQuestion: Codable {
    let id: String
    let category: String
    let prompt: String
    let answer: String
    let hint: String?
    let explanation: String
}
