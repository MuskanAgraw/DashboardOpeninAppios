import SwiftUI
import Charts

struct ContentView: View {
    @State private var topLinks: [Link] = []
    @State private var recentLinks: [Link] = []
    @State private var chartData: [ChartData] = []
    
    var body: some View {
        VStack {
            // Title and settings icon
            HStack {
                Text("Dashboard")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.white)
                    .font(.title)
            }
            .padding()
            .padding(.top, 0) // Adjust this padding for space at the top
            
            Spacer()
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(greetingMessage())
                            .font(.title3)
                            .padding(.bottom, 0)
                        HStack {
                            Text("Muskan Agrawal")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("👋")
                                .font(.title)
                        }
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
                
                // ChartView
                if !chartData.isEmpty {
                    ChartView(data: chartData)
                        .frame(height: 300)
                        .padding()
                } else {
                    Text("Loading...") // Show loading message while data is being fetched
                }
                
                // WhatsApp and FAQ boxes
                VStack(spacing: 10) {
                    // WhatsApp box
                    HStack {
                        Image("whatsapp-green") // Custom image for WhatsApp
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("WhatsApp")
                            .foregroundColor(.black)
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding()
                    .background(Color(red: 0.9, green: 1, blue: 0.9))
                    .cornerRadius(20)
                    
                    // FAQ box
                    HStack {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.blue)
                        Text("Frequently asked questions")
                            .foregroundColor(.black)
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding()
                    .background(Color(red: 0.80, green: 0.90, blue: 1))
                    .cornerRadius(20)
                }
                .padding(.horizontal, 20) // Adjust the horizontal padding to fit the screen
                .padding(.bottom, 20) // Add space below the WhatsApp box
            }
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.96, green: 0.95, blue: 0.95))
            .cornerRadius(25, corners: [.topLeft, .topRight])
            .shadow(radius: 10)
            .padding(.top, 0) // Adjust this padding for space between title and box
            
            // Footer
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "link")
                        Text("Links")
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "book")
                        Text("Courses")
                    }
                    Spacer()
                    Spacer() // Add Spacer
                    VStack {
                        Circle()
                            .foregroundColor(.blue)
                            .frame(width: 45, height: 45)
                            .overlay(
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.title)
                            )
                            .shadow(radius: 8) // Add shadow
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "megaphone")
                        Text("Campaigns")
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    Spacer()
                }
                .padding(.vertical, 10) // Adjust vertical padding here
                .padding(.horizontal, 20) // Adjust horizontal padding here
                .foregroundColor(.black)
            }
            .background(Color.white)
        }
        .background(Color.blue.edgesIgnoringSafeArea(.all)) // Full screen blue background
        .onAppear(perform: loadData)
    }
    
    func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12:
            return "Good Morning"
        case 12..<17:
            return "Good Afternoon"
        case 17..<21:
            return "Good Evening"
        default:
            return "Good Night"
        }
    }
    
    func loadData() {
        // Generate random chart data for demonstration
        let randomChartData = (1...10).map { index in
            ChartData(id: index, day: Calendar.current.date(byAdding: .day, value: -index, to: Date())!, value: Double.random(in: 0...100))
        }
        
        // Assign the random chart data to the chartData state variable
        self.chartData = randomChartData
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Extend View to allow rounded corners on specific edges
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
