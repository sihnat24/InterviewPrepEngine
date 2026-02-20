import SwiftUI

struct QuizView: View {

    // State
    @State private var questions: [QuizQuestion] = []
    @State private var currentIndex = 0

    @State private var showHint = false
    @State private var showAnswer = false
    @State private var showStats = false
    @State private var pendingConfidence: Bool? = nil

    private var currentQuestion: QuizQuestion? {
        currentIndex < questions.count ? questions[currentIndex] : nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // Header
            HStack {
                Text(showStats ? "Learning Stats" : "Daily Coding Quiz")
                    .font(.headline)

                Spacer()

                Button(showStats ? "Back" : "Stats") {
                    showStats.toggle()
                }
            }

            Divider()

            if showStats {
                StatsView()
            } else {
                quizBody
            }
        }
        .padding()
        .frame(width: 320)
        .onAppear {
            if questions.isEmpty {
                questions = DailyQuizEngine.todaysQuestions()
            }
        }
    }

    private var quizBody: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {

                if let q = currentQuestion {

                    // PROMPT
                    Text(q.prompt)
                        .font(.system(size: 13))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // HINT
                    if showHint, let hint = q.hint {
                        Text("💡 \(hint)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }

                    if showAnswer {

                        Divider()

                        Text("Answer")
                            .font(.subheadline)
                            .bold()

                        VStack(alignment: .leading, spacing: 8) {
                            Text(q.answer)
                                .foregroundColor(.green)

                            Text(q.explanation)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }

                        Button("NEXT") {
                            advance(question: q)
                        }

                    } else {

                        Spacer(minLength: 8)

                        HStack {
                            Button {
                                pendingConfidence = false
                                showAnswer = true
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title)
                            }

                            Spacer()

                            Button {
                                pendingConfidence = true
                                showAnswer = true
                            } label: {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title)
                            }
                        }

                        if q.hint != nil {
                            Button("Hint") {
                                showHint = true
                            }
                            .font(.footnote)
                        }
                    }

                } else {
                    Text("You're done for today 🎉")
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    private func advance(question: QuizQuestion) {

        if let confident = pendingConfidence {
            ProgressManager.shared.record(
                category: question.category,
                confident: confident
            )
        }

        showHint = false
        showAnswer = false
        pendingConfidence = nil
        currentIndex += 1
    }
}
