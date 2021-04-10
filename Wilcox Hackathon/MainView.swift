//
//  MainView.swift
//  Wilcox Hackathon
//
//  Created by Rosalie Wessels on 4/9/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            
            Image("studyBackground").navigationBarHidden(true) // photo credit: https://www.lsprints.co.uk/ekmps/shops/lsprints/images/stock-designs-polka-dots-baby-blue-white-38270-p.jpg
            
            
            VStack {
                Spacer()
                
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
                
                Spacer()
                
                VStack {
                    Text("Your Groups:")
                        .fontWeight(.heavy)
                        .padding(5)
                    
                    GroupBox(groupName: "Chemistry")
                        .padding()
                    GroupBox(groupName: "AP World History")
                        .padding()
                    GroupBox(groupName: "AP CSP")
                        .padding()
                }
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius:3)
                
                Spacer()
                
                HStack {
                    Image(systemName: "person.fill").foregroundColor(Color.black).padding(.leading)
                    Text("dabomb.com.yourmom").multilineTextAlignment(.leading).foregroundColor(Color.black)
                    NavigationLink(destination: JoinGroupView()) {
                        Image(systemName: "plus.circle.fill").foregroundColor(Color.black)
                        Text("find group").foregroundColor(Color.black)
                    }
                    .padding()
                }
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius:3)
                
                Spacer()
            }
            
        }
    }
}

struct GroupBox: View {
    @State var groupName: String
    var body: some View {
        HStack {
            Text(groupName).fontWeight(.heavy)
            
            HStack {
                NavigationLink(destination: ContentView()) {
                    Image(systemName: "bubble.right.fill").foregroundColor(Color.black)
                    Text("chat").foregroundColor(Color.black)
                }
            }
            
            HStack {
                NavigationLink(destination: ContentView()) {
                    Image(systemName: "phone.fill").foregroundColor(Color.black)
                    Text("call").foregroundColor(Color.black)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
