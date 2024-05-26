import SwiftUI

struct ContentView: View {
    @State private var topLinks: [Link] = []
    @State private var recentLinks: [Link] = []
    @State private var chartData: [ChartData] = []
    @State private var isTopLinksSelected: Bool = true // Track which button is selected

    var body: some View {
        NavigationView {
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

                ScrollView {
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
                        
                        // Button Bar
                        HStack {
                            Button(action: {
                                self.isTopLinksSelected = true
                            }) {
                                Text("Top Links")
                                    .padding()
                                    .foregroundColor(self.isTopLinksSelected ? .blue : .white)
                            }
                            .background(self.isTopLinksSelected ? Color.white : Color.blue)
                            .cornerRadius(8)
                            
                            Button(action: {
                                self.isTopLinksSelected = false
                            }) {
                                Text("Recent Links")
                                    .padding()
                                    .foregroundColor(!self.isTopLinksSelected ? .blue : .white)
                            }
                            .background(!self.isTopLinksSelected ? Color.white : Color.blue)
                            .cornerRadius(8)
                        }
                        .padding(.vertical, 10)

                        // Amazon Logo and Link
                        if isTopLinksSelected {
                            VStack {
                                HStack {
                                    Spacer()
                                    Image("Amazon-logo-meaning")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .aspectRatio(contentMode: .fit)
                                        .padding()
                                    VStack(alignment: .leading) {
                                        Button(action: {
                                            // Copy link action
                                        }) {
                                            Text("https://amazon.com")
                                                .foregroundColor(.blue)
                                        }
                                        Button(action: {
                                            // Copy button action
                                        }) {
                                            Text("Copy")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            .padding()
                        }

                        // WhatsApp and FAQ boxes
                        VStack(spacing: 10) {
                            // WhatsApp box
                            HStack {
                                Image(systemName: "message.fill") // Custom image for WhatsApp
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.green) // Custom color for the WhatsApp icon
                                Text("Talk with us")
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
                                Text("Frequently Asked Questions")
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
                    .shadow(radius: 10)
                    .padding(.top, 0) // Adjust this padding for space between title and box
                }
                
                // Footer
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: EmptyView()) {
                            VStack {
                                Image(systemName: "link")
                                Text("Links")
                            }
                        }
                        Spacer()
                        NavigationLink(destination: EmptyView()) {
                            VStack {
                                Image(systemName: "book")
                                Text("Courses")
                            }
                        }
                        Spacer()
                        Spacer() // Add Spacer
                        NavigationLink(destination: EmptyView()) {
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
                        }
                        Spacer()
                        NavigationLink(destination: EmptyView()) {
                            VStack {
                                Image(systemName: "megaphone")
                                Text("Campaigns")
                            }
                        }
                        Spacer()
                        NavigationLink(destination: EmptyView()) {
                            VStack {
                                Image(systemName: "person.crop.circle")
                                Text("Profile")
                            }
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
        // Generate random chart data
        let values: [Double] = (1...11).map { _ in Double.random(in: 20...100) }
        let calendar = Calendar.current
        var data: [ChartData] = []
        for (index, value) in values.enumerated() {
            let date = calendar.date(byAdding: .month, value: index, to: calendar.date(from: DateComponents(year: 2023, month: 1))!)!
            data.append(ChartData(id: index + 1, day: date, value: value))
        }
        self.chartData = data

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct EmptyView: View {
    var body: some View {
        Text("Placeholder")
    }
}
