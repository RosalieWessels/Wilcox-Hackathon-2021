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
                            Text("StudyChats")
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
                    .background(Image("background8").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea())
                    .navigationBarHidden(true)
                }
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
            .foregroundColor(.black)
            .font(Font.custom("ArialRoundedMTBold", size: 25))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(radius:3)
    }
}
