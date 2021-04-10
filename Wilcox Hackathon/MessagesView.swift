//
//  MessagesView.swift
//  Wilcox Hackathon
//
//  Created by Rosalie Wessels on 4/10/21.
//

import SwiftUI

struct MessagesView: View {
    
    let chatroom: Chatroom
    @ObservedObject var viewModel = MessagesViewModel()
    @State var messageField = ""
    
    init(chatroom: Chatroom) {
        self.chatroom = chatroom
        viewModel.fetchData(docId: chatroom.id)
    }
    
    var body: some View {
        VStack {
            List(viewModel.messages) { message in
                VStack {
                    HStack {
                        Text(message.name)
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text(message.content)
                            .font(.subheadline)
                        Spacer()
                    }
                }
            }
            
            HStack {
                TextField("Enter message...", text: $messageField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    viewModel.sendMessage(messageContent: messageField, docId: chatroom.id)
                }, label: {
                    Text("Send")
                })
            }
            .padding(.horizontal)
        }
            .navigationBarTitle(chatroom.title)
            .navigationBarHidden(false)
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(chatroom: Chatroom(id: "10101", title: "Sample", joinCode: 10))
    }
}
