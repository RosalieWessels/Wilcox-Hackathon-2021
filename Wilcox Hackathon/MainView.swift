//
//  MainView.swift
//  Wilcox Hackathon
//
//  Created by Rosalie Wessels on 4/9/21.
//

import SwiftUI
import Firebase

struct MainView: View {
    @State var db = Firestore.firestore()
    @StateObject var model = ModelData()
    @ObservedObject var viewModel = ChatroomsViewModel()
    
    @State var myClasses = []
    @State var myDocIDs = []
    @State var dict = [String: String]()
    
    init() {
        viewModel.fetchData()
    }
    
    var body: some View {
        ZStack {
            
            Image("background8").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea()
            
            
            VStack {
                
                
                
                Spacer()
                
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
                
                Spacer()
                
                VStack {
                    Text("Your Groups:")
                        .fontWeight(.heavy)
                        .padding(5)
                    
                    VStack {
                        if myClasses.count != 0 {
                            ForEach(0..<myClasses.count) { index in
                                GroupBox(groupName: myClasses[index] as! String, groupId: myDocIDs[index] as! String, viewModel: viewModel)
                                    .padding()
                                
                            }
                        }
                        
                    }
                }
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius:3)
                
                Spacer()
                
                VStack {
                    HStack {
                        Image(systemName: "person.fill").foregroundColor(Color.black).padding(.leading)
                        Text("\(Auth.auth().currentUser?.email ?? "")").multilineTextAlignment(.leading).foregroundColor(Color.black)
                    }
                    .padding(.top)
                    .padding(.trailing)
                    HStack {
                        NavigationLink(destination: JoinGroupView()) {
                            Image(systemName: "plus.circle.fill").foregroundColor(Color.black)
                            Text("find group").foregroundColor(Color.black)
                        }
                        .padding()
                    }
                }
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius:3)
                .frame(maxWidth: UIScreen.main.bounds.size.width - 60)
                
                Spacer()
                
                Button(action: model.logOut) {
                    Text("Log out")
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius:3)

                
            }
            
        }.onAppear(perform: {
            myGroups()
        })
    }
    
    func myGroups() {
        db.collection("groups").whereField("members", arrayContains: "\(Auth.auth().currentUser?.email ?? "")")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        if let name = document.get("name") as? String {
                            print("YOU ARE IN \(name)")
                            if document == document {
                                let documentid = String(document.documentID)
                                myClasses.append(name)
                                myDocIDs.append(documentid)
                                dict[documentid] = name
                            }
                        }
                        
                    }
                    print(myClasses)
                    print(myDocIDs)
                }
        }
        
    }
    
}

struct GroupBox: View {
    @State var groupName: String
    @State var groupId : String
    @State var viewModel : ChatroomsViewModel
    
    
    var body: some View {
        HStack {
            Text(groupName).fontWeight(.heavy)
            
            Spacer()
            
            HStack {
                NavigationLink(destination: MessagesView(chatroom: getChatroom())) {
                    Image(systemName: "bubble.right.fill").foregroundColor(Color.black)
                    Text("chat").foregroundColor(Color.black)
                }
            }
            
            HStack {
                NavigationLink(destination: CallView()) {
                    Image(systemName: "phone.fill").foregroundColor(Color.black)
                    Text("call").foregroundColor(Color.black)
                }
            }
        }.frame(maxWidth: UIScreen.main.bounds.size.width - 60)
    }
    
    func getChatroom() -> Chatroom {
        var correctChatroom = Chatroom(id: "10101", title: "Sorry, not found", joinCode: 131231)
        print(viewModel.chatrooms)
        for chatroom in viewModel.chatrooms {
            let trimmedgroupId = groupId.trimmingCharacters(in: .whitespaces)
            let trimmedChatroomId = chatroom.id.trimmingCharacters(in: .whitespaces)
            print("chatroom ID to find", trimmedgroupId)
            print("chatroom ID I have", trimmedChatroomId)
            if trimmedChatroomId == trimmedgroupId {
                correctChatroom = chatroom
            }
        }
        return correctChatroom
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
