import Foundation

struct QuestionScheduler {

    // Weighted random sampling
    static func selectIndex(from questions: [QuizQuestion]) -> Int {
        let total = questions.reduce(0) { $0 + $1.priority }
        let r = Double.random(in: 0..<total)

        var cumulative = 0.0
        for (index, q) in questions.enumerated() {
            cumulative += q.priority
            if r < cumulative {
                return index
            }
        }
        return 0
    }

    // Cooling / heating rule
    static func updatePriority(
        question: inout QuizQuestion,
        confident: Bool
    ) {
        if confident {
            question.priority *= 0.6   // ❄️ cool
        } else {
            question.priority *= 1.4   // 🔥 heat
        }

        question.priority = min(
            max(question.priority, 0.2),
            3.0
        )

        question.lastSeen = Date()
    }
}
