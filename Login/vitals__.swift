import SwiftUI

struct VitalsPage: View {
    // Sample data
    @State private var walkingDistance: Double = 3.5 // in kilometers
    @State private var stepsCount: Int = 5000
    @State private var heartRate: Int = 75
    @State private var hoursOfSleep: Double = 7.5

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Button(action: {
                            // Handle back button action
                        }) {
                            Image(systemName: "arrow.left.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.blue)
                        }
                        .padding(.top, 20)
                        .padding(.leading, 20)

                        

                        Text("Vitals")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center) // Center align the text

                        Spacer()
                    }

                    HStack(spacing: 20) {
                        VitalsSquareCard(title: "Walking Distance", value: "\(walkingDistance) km", color: Color.blue.opacity(0.6))
                        VitalsSquareCard(title: "Heart Rate", value: "\(heartRate) bpm", color: Color.red.opacity(0.7))
                    }
                    .padding()

                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: UIScreen.main.bounds.width / 2.5, height: 150)
                            .overlay(
                                Text("Vitals")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            )
                            .offset(y: -50) // Adjust the offset to move the central circle up

                        HStack(spacing: 20) {
                            VitalsSquareCard(title: "Steps", value: "\(stepsCount)", color: Color.green.opacity(0.8))
                            VitalsSquareCard(title: "Sleep", value: "\(hoursOfSleep) hrs", color: Color.purple.opacity(0.8))
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
            .foregroundColor(.black)
            .background(Color.white.opacity(0.1)) // You can use a custom color if needed
        }
    }
}

struct VitalsSquareCard: View {
    var title: String
    var value: String
    var color: Color

    var body: some View {
        VStack {
            Circle()
                .fill(color)
                .frame(width: UIScreen.main.bounds.width / 2.2, height: 250)
                .overlay(
                    VStack {
                        Text(value)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.bottom, 20)

                        Text(title)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                )
        }
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

struct VitalsPage_Previews: PreviewProvider {
    static var previews: some View {
        VitalsPage()
    }
}



//TabView
//{
//    Text("HOME")
//        .tabItem {
//            Label("",image: "homeicon")
//        }
//        
//     Text("Appointment")
//            .tabItem {
//                Label("",image:"appointicon")
//            }
//    
//    Text("Vitals")
//           .tabItem {
//               Label("",image:"vitalsicon")
//           }
//    
//    Text("Community")
//           .tabItem {
//               Label("",image:"momcom")
//           }
//    }
    



     
       
