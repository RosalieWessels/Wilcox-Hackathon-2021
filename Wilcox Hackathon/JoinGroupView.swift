//
//  JoinGroupView.swift
//  Wilcox Hackathon
//
//  Created by Rosalie Wessels on 4/9/21.
//

import SwiftUI

struct JoinGroupView: View {
    
    @State var groupCode: String = ""
    @ObservedObject var viewModel = ChatroomsViewModel()
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack {
            
            Image("studyBackground") // photo credit: https://www.lsprints.co.uk/ekmps/shops/lsprints/images/stock-designs-polka-dots-baby-blue-white-38270-p.jpg
            
            VStack(alignment:.leading) {
                
                Spacer()
                
                Text("Finding a Group").font(.system(size: 40))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .shadow(radius:3)
                
                VStack {
                    Text("Recommended Groups").fontWeight(.heavy).padding(5)
                    SuggestedGroupBox(groupName: "Precalc").padding()
                    SuggestedGroupBox(groupName: "Art History").padding()
                }
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius:3)
                
                VStack{
                    Text("Join Group with Code").fontWeight(.heavy).padding(5)
                    HStack{
                        Button(action: {joinGroup()}){
                            Image(systemName: "plus.circle.fill").foregroundColor(Color.black)
                        }
                        TextField("enter code", text: $groupCode).padding(.all, 5)
                            .border(Color(UIColor.separator))
                            .frame(width:100, height:30)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius:3)
                
                NavigationLink(destination: CreateGroupView()) {
                    Image(systemName: "plus.circle.fill").foregroundColor(Color.black)
                    Text("Create New Group").foregroundColor(Color.black).fontWeight(.heavy)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius:3)
                
                HStack{
                    NavigationLink(destination: FormView()) {
                        Image(systemName: "doc.badge.gearshape.fill").foregroundColor(Color.black)
                        Text("Redo Your Recommendations").foregroundColor(Color.black).fontWeight(.heavy)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius:3)
                
                Spacer()
            }
        }
    }
    
    func joinGroup() {
        viewModel.joinChatroom(code: groupCode, handler: {
            self.presentation.wrappedValue.dismiss()
        })
    }
}

struct SuggestedGroupBox: View {
    @State var groupName: String
    @State private var showingAlert = false
    var body: some View {
        HStack {
            Text(groupName).fontWeight(.heavy)
            
            Button(action: {joinGroup()}){
                Image(systemName: "plus.circle.fill").foregroundColor(Color.black)
                Text("join").foregroundColor(Color.black)
            }
            
            HStack {
                // should this take the user to a different page or just show like an alert?
                Button(action: {showingAlert = true}) {
                    Image(systemName: "magnifyingglass.circle.fill").foregroundColor(Color.black)
                    Text("info").foregroundColor(Color.black)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("\(groupName) Info"), message: Text("the tags and maybe the members?"), dismissButton: .default(Text("Close")))
                }
            }
        }
    }
    
    func joinGroup() {
        print("JOIN SUGGESTED GROUP _ NEEDS ADDED")
    }
}

struct JoinGroupView_Previews: PreviewProvider {
    static var previews: some View {
        JoinGroupView()
    }
}
