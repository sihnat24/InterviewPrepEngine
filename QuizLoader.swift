import Foundation

class QuizLoader {
    static func loadQuestions() -> [QuizQuestion] {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let questions = try? JSONDecoder().decode([QuizQuestion].self, from: data)
        else {
            return []
        }
        return questions
    }
}
