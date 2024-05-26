
import SwiftUI
import Charts

struct ChartView: View {
    var data: [ChartData]

    var body: some View {
        Chart {
            ForEach(data) { item in
                LineMark(
                    x: .value("Day", item.day),
                    y: .value("Value", item.value)
                )
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .month)) {
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.month(.abbreviated))
            }
        }
    }
}
