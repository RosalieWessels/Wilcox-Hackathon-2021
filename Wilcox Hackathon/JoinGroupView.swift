//
//  JoinGroupView.swift
//  Wilcox Hackathon
//
//  Created by Rosalie Wessels on 4/9/21.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct JoinGroupView: View {
    @State var db = Firestore.firestore()
    @State var groupCode: String = ""
    @State var user = Auth.auth().currentUser
    @ObservedObject var viewModel = ChatroomsViewModel()
    @Environment(\.presentationMode) var presentation
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var showAlert = false
    @State var titleNews = "Good News"
    @State var descriptionNews = "You were succesfully added to the group!"
    
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
                
                NavigationLink(destination: CreateNewGroupView()) {
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
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text(titleNews), message: Text(descriptionNews), dismissButton: Alert.Button.default(
                    Text("Ok"), action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                ))
            })
        }
    }
    
    func joinGroup() {
        print("lets join!")
        if (user != nil) {
            //Add user to group in database
            db.collection("groups").whereField("id", isEqualTo: groupCode)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                            
                            let groupsDatabaseID = document.documentID
                            if let groupName = document.get("name") as? String {
                                db.collection("groups").document(document.documentID).updateData([
                                    "members": FieldValue.arrayUnion([self.user!.email])
                                ])
                                
                                viewModel.joinChatroom(code: groupCode, handler: {
                                    self.presentation.wrappedValue.dismiss()
                                })
                                
                                //add user to chatroom
                                let docRef = db.collection("chatrooms").document(groupsDatabaseID)

                                docRef.getDocument { (document, error) in
                                    if let document = document, document.exists {
                                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                                        print("Document data: \(dataDescription)")
                                        
                                        db.collection("chatrooms").document(groupsDatabaseID).updateData([
                                            "users": FieldValue.arrayUnion([self.user!.email])
                                        ])
                                        
                                        showAlert = true
                                        
                                    } else {
                                        print("Document does not exist")
                                        
                                        db.collection("chatrooms").document(groupsDatabaseID).setData([
                                            "joinCode": Int.random(in: 1111...9999),
                                            "title": groupName,
                                            "users": [user!.email]
                                        ]) { err in
                                            if let err = err {
                                                print("Error writing document: \(err)")
                                            } else {
                                                print("Document successfully written!")
                                                showAlert = true
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
            }
        }
        
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
