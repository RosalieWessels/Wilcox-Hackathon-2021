//
//  CreateGroupView.swift
//  Wilcox Hackathon
//
//  Created by Sally King on 4/10/21.
//

import SwiftUI

struct CreateGroupView: View {
    
    struct Tag: Identifiable, Hashable {
        let name: String
        let id = UUID()
    }
    
    private var tags = [
        Tag(name: "Chemisty"),
        Tag(name: "Physics"),
        Tag(name: "9th Grade"),
        Tag(name: "10th Grade"),
        Tag(name: "11th Grade"),
        Tag(name: "12th Grade"),
        Tag(name: "Pinewood"),
        Tag(name: "Los Altos High School")
    ]
    
    @State var newGroup = ""
    @State private var multiSelection = Set<UUID>()
    
    var body: some View {
        VStack {
            VStack(alignment:.leading) {
                TextField("Fill in new group name", text:$newGroup)
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5.0)
                    .navigationTitle("Group Name")
            }
            .padding(.horizontal, 15)
            
            NavigationView {
                List(tags, selection: $multiSelection) {
                    Text($0.name)
                }
                .navigationTitle("Group Tags")
                .toolbar { EditButton()}
            }
            
            Button(action: {}) {
                HStack {
                    Spacer()
                    Text("Create")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .padding(.vertical, 10)
            .background(Color.black)
            .cornerRadius(4)
            .padding(.horizontal, 50)
        }
    }
    
    func createGroup() {
        print("creating group in a distant internet thingie called Firebase")
        // create a new group in firebase with the new group name and tags
    }
    
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView()
    }
}
