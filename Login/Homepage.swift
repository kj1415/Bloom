import SwiftUI

struct HomePageView: View {
    @State private var currentWeek: Double = 1
    @State private var medicationReminders: [MedicationReminder] = []

    var body: some View {
        ZStack {
            Color(.white).brightness(0.70).ignoresSafeArea()
            ScrollView {
                // Week Scroller
                WeekScrollerView(currentWeek: $currentWeek)
                    .frame(height: 150)

                // Circular Loading View with Embryo Image
                myCircularLoadingView(currentWeek: $currentWeek)
                    .frame(width: 150, height: 150)
                    .padding()

                // Heading for Daily Medicine
                Text("Daily Medicine")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()

                // Horizontal ScrollView of Large Square Buttons
                LargeSquareButtonsScrollView()

                // Medication Reminder Section
                MedicationReminderSection(medicationReminders: $medicationReminders)

                // Upcoming Medicine Reminders
                UpcomingMedicineReminders()
            }

            // Settings Logo in the Top Right Corner
            HStack {
                Spacer()
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}

struct MedicationReminder {
    var pillName: String
    var amount: Int
    var isBeforeFood: Bool
    var selectedTime: Date
}

struct WeekScrollerView: View {
    @Binding var currentWeek: Double

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(1...40, id: \.self) { week in
                    Text("\(week) weeks")
                        .padding(10)
                        .foregroundColor(week == Int(currentWeek) ? .blue : .black)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .onAppear {
                            // Automatically move to the next week every week
                            DispatchQueue.main.asyncAfter(deadline: .now() + Double(week)) {
                                withAnimation {
                                    currentWeek = Double(week)
                                }
                            }
                        }
                }
            }
            .padding()
        }
    }
}

struct myCircularLoadingView: View {
    @Binding var currentWeek: Double
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 10)
                    .opacity(0.3)

                Circle()
                    .trim(from: 0, to: CGFloat(min(1.0, 0.01 * currentWeek)))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: 270))

                Image(systemName: "figure.child.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)

            }
        }
    }
}

struct LargeSquareButton<Destination: View>: View {
    var systemImageName: String
    var destinationScreen: Destination

    var body: some View {
        NavigationLink(destination: destinationScreen) {
            VStack {
                Image(systemName: systemImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                    .foregroundColor(.blue)

                Text("Button")
                    .foregroundColor(.blue)
                    .padding(.top, 8)
            }
        }
    }
}

struct LargeSquareButtonsScrollView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                // Additional Box for Pro Health
                LargeSquareBox(title: "Mom's recipes", color: .teal, symbolName: "fork.knife.circle")
                // Additional Box for Medicine
                LargeSquareBox(title: "Medicine", color: .teal, symbolName: "pills.fill")
                // Additional Box for Appointments
                LargeSquareBox(title: "Appointments", color: .teal, symbolName: "calendar")
                // Additional Box for Exercise
                LargeSquareBox(title: "Exercise", color: .teal, symbolName: "bolt.fill")
            }
            .padding()
        }
    }
}

struct LargeSquareBox: View {
    var title: String
    var color: Color
    var symbolName: String

    var body: some View {
        VStack {
            Rectangle()
                .fill(color)
                .frame(width: 120, height: 120)
                .overlay(
                    Image(systemName: symbolName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .padding(.top, 25),
                    alignment: .top
                )
                .overlay(
                    Text(title)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.top, 50)
                )
                .cornerRadius(10)
        }
    }
}

struct MedicationReminderSection: View {
    @Binding var medicationReminders: [MedicationReminder]

    var body: some View {
        VStack {
            Text("Medication Reminder")
                .font(.title)
                .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(medicationReminders.indices, id: \.self) { index in
                        EllipseMedicationReminderView(medicationReminder: medicationReminders[index])
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct UpcomingMedicineReminders: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Upcoming Reminders")
                .font(.headline)
                .foregroundColor(.blue)

            // Here you can add the logic to fetch and display upcoming reminders from MedBuddy
            // Sample content
            ForEach(1...3, id: \.self) { index in
                Text("Medicine \(index)")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
        }
    }
}

struct EllipseMedicationReminderView: View {
    var medicationReminder: MedicationReminder

    var body: some View {
        VStack(spacing: 8) {
            Ellipse()
                .fill(Color.blue)
                .frame(width: 120, height: 60)
                .overlay(
                    VStack(spacing: 4) {
                        Text(medicationReminder.pillName)
                            .foregroundColor(.white)
                            .font(.headline)
                        Text("Amount: \(medicationReminder.amount)")
                            .foregroundColor(.white)
                            .font(.subheadline)
                        Text("Before Food: \(medicationReminder.isBeforeFood ? "Yes" : "No")")
                            .foregroundColor(.white)
                            .font(.subheadline)
                        Text("Time: \(formattedTime(from: medicationReminder.selectedTime))")
                            .foregroundColor(.white)
                            .font(.subheadline)
                    }
                    .padding()
                )
        }
    }

    func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}











/*

//
//  Homepage.swift
//  Login
//
//  Created by user1 on 01/01/24.
//

import SwiftUI

struct Homepage: View {
    var body: some View {
        //Image("logo1")
        Text(getCurrentMonth()).font(.headline).padding()
        // Title "MedBuddy"
        
        // ScrollView for dates and days
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(1...30, id: \.self) { day in
                    DateBox(day: day)
                }
            }
        }
        .padding(.horizontal)
        
        
        
        
        
        
        
        
        
        
        
        
        Text("Services")
            .bold()
        HStack{
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/
                   ,
                   label: {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal,50)
                    .background(Color.blue)
                    .cornerRadius(100)
            })
            
            /*  Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/
             ,
             label: {
             Text("Medic")
             .foregroundColor(.white)
             .padding()
             .padding(.horizontal,50)
             .background(Color.red)
             .cornerRadius(10)
             })*/
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/
                   ,
                   label: {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal,50)
                    .background(Color.red)
                    .cornerRadius(10)
            })
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/
                   ,
                   label: {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal,50)
                    .background(Color.pink)
                    .cornerRadius(10)
            })
        }
        
        
    }
    
    
    
    func getCurrentMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: Date())
    }
    
    
    #Preview {
        Homepage()
    }
    
    
}
 /**/*/
