//
//  ContentView.swift
//  Wilcox Hackathon
//
//  Created by Rosalie Wessels on 4/9/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Text("Welcome.")
                    .font(Font.custom("ArialRoundedMTBold", size: 40))
                    .foregroundColor(.white)
                
                VStack {
                    Spacer()
                    
                      HStack {
                        NavigationLink(destination: SignUpScreen()) {
                            LogInOrSignUpText(text: "Sign Up")
                        }
                        
                        NavigationLink(destination: LogInScreen()) {
                            LogInOrSignUpText(text: "Log In")
                        }
                        
                    }
                      .padding(.horizontal, 10)
                    
                }
                
            }
            .background(Image("wallpaper"))
            .navigationBarHidden(true)
        }
    }
    
    //GET RID OF
    func pushTestData() {
        db.collection("cities").document("LA").setData([
            "name": "Los Angeles",
            "state": "CA",
            "country": "USA"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LogInOrSignUpText: View {
    @State var text : String
    var body: some View {
        Text(text)
        .foregroundColor(.white)
        .font(Font.custom("ArialRoundedMTBold", size: 25))
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("DarkGray").opacity(0.8))
        .cornerRadius(20)
    }
}
