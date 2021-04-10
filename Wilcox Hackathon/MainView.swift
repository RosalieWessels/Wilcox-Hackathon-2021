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
    
    @State var myClasses = []
    @State var myDocIDs = []
    @State var dict = [String: String]()
    
    var body: some View {
        ZStack {
            
            Image("studyBackground").navigationBarHidden(true) // photo credit: https://www.lsprints.co.uk/ekmps/shops/lsprints/images/stock-designs-polka-dots-baby-blue-white-38270-p.jpg
            
            
            VStack {
                
                
                
                Spacer()
                
                Button(action: model.logOut) {
                    Text("Log out")
                }
                
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
                    
                    VStack {
                        if myClasses.count != 0 {
                            ForEach(0..<myClasses.count) { index in
                                GroupBox(groupName: myClasses[index] as! String)
                                    .padding()
                                
                            }
                        }
                        
                    }
                    
//                    GroupBox(groupName: "Chemistry")
//                        .padding()
//                    GroupBox(groupName: "AP World History")
//                        .padding()
//                    GroupBox(groupName: "AP CSP")
//                        .padding()
                }
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius:3)
                
                Spacer()
                
                HStack {
                    Image(systemName: "person.fill").foregroundColor(Color.black).padding(.leading)
                    Text("\(Auth.auth().currentUser?.email ?? "")").multilineTextAlignment(.leading).foregroundColor(Color.black)
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
    var body: some View {
        HStack {
            Text(groupName).fontWeight(.heavy)
            
            HStack {
                NavigationLink(destination: ChatView()) {
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
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
