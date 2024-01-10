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
        
        TabView
        {
            Text("HOME")
                .tabItem {
                    Label("",image: "homeicon")
                }
                
             Text("Appointment")
                    .tabItem {
                        Label("",image:"appointicon")
                    }
            
            Text("Vitals")
                   .tabItem {
                       Label("",image:"vitalsicon")
                   }
            
            Text("Community")
                   .tabItem {
                       Label("",image:"momcom")
                   }
            
            
        }
       
        
    }
}

#Preview {
    Homepage()
}