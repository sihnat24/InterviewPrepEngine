Here's a cleaner version:

---

# InterviewPrepEngine

A lightweight iOS flashcard app for staying sharp on technical interview topics across ML, statistics, SWE, and quant. The intended use case is low-friction, high-frequency.

### How to Use It

Each session surfaces a question from one of the four categories. Think through your answer, then reveal it. The app tracks your responses per category over time, which tends to be more honest than self-assessment about where your actual gaps are.

The daily question count is configurable and intentionally low by default. Consistency matters more than volume here.

The question bank is driven by a local `questions.json` file. To add questions, edit that file directly — no code changes needed. Each entry takes a category, a prompt, and an answer.

### Setup

1. Open Xcode and create a new iOS App project using the SwiftUI template
2. Replace the generated Swift files with the files from this repository
3. Add `questions.json` to the project bundle (ensure "Add to target" is checked)
4. Run on simulator or device

### Extending the Question Bank

`questions.json` is the only file you need to touch. Add a new object with `category`, `question`, and `answer` fields and the app picks it up on next launch. Good sources: past coursework, problem sets, anything that came up in an actual interview that you had to look up afterward.
