//
//  ChatView.swift
//  Wilcox Hackathon
//
//  Created by Rosalie Wessels on 4/10/21.
//

import SwiftUI
import Foundation
import Firebase

struct ChatView: View {
    @ObservedObject var viewModel = ChatroomsViewModel()
    
    init() {
        viewModel.fetchData()
    }
    
    var body: some View {
        List(viewModel.chatrooms) { chatroom in
            NavigationLink (destination: MessagesView(chatroom: chatroom)){
                HStack {
                    Text(chatroom.title)
                    Spacer()
                }
                
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

struct Chatroom: Codable, Identifiable {
    var id: String
    var title: String
    var joinCode: Int
}

class ChatroomsViewModel: ObservableObject {
    @Published var chatrooms = [Chatroom]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    func fetchData() {
        if (user != nil) {
            db.collection("chatrooms").whereField("users", arrayContains: user!.email).addSnapshotListener({ (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("no documents returned!")
                    return
                }
                
                self.chatrooms = documents.map({docSnapshot -> Chatroom in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let title = data["title"] as? String ?? ""
                    let joincode = data["joinCode"] as? Int ?? -1
                    return Chatroom(id: docId, title: title, joinCode: joincode)
                    
                })
                
            })
        }
    }
    
    func createChatroom(title: String, handler: @escaping () -> Void) {
        if (user != nil) {
            
            db.collection("chatrooms").addDocument(data: [
                "title": title,
                //UPDATE TO GROUP ID
                "joinCode": Int.random(in: 100000..<99999),
                "users": [user!.email]
            ]) { err in
                if let err = err {
                    print("error adding document: \(err)")
                }
                else {
                    handler()
                }
            }
        }
    }
    
    func joinChatroom(code: String, handler: @escaping () -> Void) {
        if (user != nil) {
            db.collection("chatrooms").whereField("joinCode", isEqualTo: Int(code)).getDocuments() { (snapshot, error) in
                if let error = error {
                    print("error getting document: \(error)")
                }
                else {
                    for document in snapshot!.documents {
                        self.db.collection("chatrooms").document(document.documentID).updateData([
                            "users": FieldValue.arrayUnion([self.user!.email])
                        ])
                        handler()
                    }
                }
            }
        }
    }
    
}
