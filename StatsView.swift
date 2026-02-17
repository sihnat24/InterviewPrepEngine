import SwiftUI

struct StatsView: View {

    let stats = ProgressManager.shared.stats()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Learning Stats")
                .font(.headline)

            if stats.isEmpty {
                Text("No data yet — answer a few questions first.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            } else {
                ForEach(stats.keys.sorted(), id: \.self) { category in
                    if let p = stats[category] {
                        CategoryStatRow(
                            category: category,
                            progress: p
                        )
                    }
                }
            }
        }
        .padding()
        .frame(width: 320)
    }
}
