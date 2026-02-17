import Foundation

struct QuestionBank {

    static func loadQuestions() -> [QuizQuestion] {
        guard let url = Bundle.main.url(
            forResource: "questions",
            withExtension: "json"
        ) else {
            print("❌ questions.json not found in bundle")
            return []
        }

        do {
            let data = try Data(contentsOf: url)

            let rawQuestions = try JSONDecoder().decode(
                [RawQuestion].self,
                from: data
            )

            return rawQuestions.map { raw in
                QuizQuestion(
                    id: raw.id,
                    category: raw.category,
                    prompt: raw.prompt,
                    answer: raw.answer,
                    hint: raw.hint,
                    explanation: raw.explanation,
                    priority: 1.0
                )
            }

        } catch {
            print("❌ Failed to decode questions.json:", error)
            return []
        }
    }
}
