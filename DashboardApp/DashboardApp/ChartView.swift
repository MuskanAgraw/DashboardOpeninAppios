import SwiftUI
import Charts

struct ChartView: View {
    var data: [ChartData]

    var body: some View {
        Chart {
            ForEach(data) { item in
                LineMark(
                    x: .value("Day", formattedDate(item.day)),
                    y: .value("Value", item.value)
                )
            }
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd" // Example format: "May 21"
        return formatter.string(from: date)
    }
}
