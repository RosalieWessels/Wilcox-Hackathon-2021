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
    @AppStorage("log_Status") var status = DefaultStatus.status
    @StateObject var model = ModelData()
    
    var body: some View {
        NavigationView {
            ZStack {
                if status == true {
                    MainView()

                }
                else {
                    ZStack {
                        
                        VStack {
                            Text("Welcome to")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                                .shadow(radius:3)
                            Text("Class Chats")
                                .font(.system(size: 50))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .shadow(radius:3)
                        }
                        
                        VStack {
                            Spacer()
                            
                              HStack {
                                
                                NavigationLink(destination: FullLoginView()) {
                                    LogInOrSignUpText(text: "Log In")
                                }
                                
                            }
                              .padding(.horizontal, 10)
                            
                        }
                        
                    }
                    .background(Image("studyBackground"))
                    .navigationBarHidden(true)
                }
            }
            
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
