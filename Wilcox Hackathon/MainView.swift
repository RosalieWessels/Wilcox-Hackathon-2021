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
            
            Image("studyBackground") // photo credit: https://www.lsprints.co.uk/ekmps/shops/lsprints/images/stock-designs-polka-dots-baby-blue-white-38270-p.jpg
            
            VStack {
                VStack {
                    Text("Welcome to")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                        .shadow(radius:3)
                    Text("TBD")
                        .font(.system(size: 50))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .shadow(radius:3)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(width:300, height:100)
                        .shadow(radius:3)
                    
                    VStack {
                        Text("Your Groups:")
                            .fontWeight(.heavy)
                        
                        GroupBox(groupName: "Chem", groupChat: "chatLink", groupCall: "callLink")
                    }
                }
            }
            
        }
    }
}

struct GroupBox: View {
    @State var groupName: String
    @State var groupChat: String
    @State var groupCall: String
    var body: some View {
        HStack {
            Text(groupName).fontWeight(.heavy).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            
            HStack {
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
