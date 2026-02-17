import Foundation

struct DailyQuizEngine {

    static func todaysQuestions() -> [QuizQuestion] {
        QuestionBank.loadQuestions()
    }
}
