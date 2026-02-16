//
//  ContentView.swift
//  Flyest
//
//  Created by Sarah Mitch on 1/27/26.
//
import SwiftUI
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Flyest")
        }
        .padding()
        HStack {
            Button(action: {
                print("You are logged in")
            }, label: {
                Text("Login")
                    .font(.body)
                    .bold()
                    .multilineTextAlignment(.center)
                    
            }).padding()
            
            Button(action: {
                print("Follow steps to complete signup")
            }, label: {
                Text("Sign Up")
                    .font(.body)
                    .bold()
                    .multilineTextAlignment(.center)
                
        }).padding()
            
            Button(action: {
                print("Verify to get new password")
            }, label: {
                Text("Forgot Password")
                    .font(.body)
                    .bold()
                    .multilineTextAlignment(.center)
            }).padding()
            
        }
    }
}
#Preview {
    ContentView()
}
