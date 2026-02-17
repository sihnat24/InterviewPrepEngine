import SwiftUI

struct CategoryStatRow: View {

    let category: String
    let progress: CategoryProgress

    var confidence: Double {
        guard progress.timesSeen > 0 else { return 0 }
        return Double(progress.timesConfident) / Double(progress.timesSeen)
    }

    var body: some View {
        HStack {
            Text(category.capitalized)
                .frame(width: 80, alignment: .leading)

            Text("\(Int(confidence * 100))% confident")
                .frame(width: 120, alignment: .leading)

            Text("(\(progress.timesSeen) seen)")
                .foregroundColor(.secondary)
        }
        .font(.system(size: 12))
    }
}
