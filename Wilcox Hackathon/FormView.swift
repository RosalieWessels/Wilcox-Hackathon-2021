//
//  FormView.swift
//  Wilcox Hackathon
//
//  Created by Rosalie Wessels on 4/9/21.
//

import SwiftUI

struct FormView: View {
    
    struct Tag: Hashable, Identifiable {
        let name: String
        let id = UUID()
    }
    
    struct Question: Identifiable {
        let name: String
        let choices: [Tag]
        let id = UUID()
    }
    
    private let Questions: [Question] = [
        Question(name: "Classes", choices: [Tag(name: "Chemistry"), Tag(name: "Physics"), Tag(name: "Biology"), Tag(name: "World History AP"), Tag(name: "US History AP"), Tag(name: "European History AP"), Tag(name: "AP Computer Science Principles"), Tag(name: "AP Computer Science A")]),
        Question(name: "Grades", choices: [Tag(name: "7th Grade"), Tag(name: "8th Grade"), Tag(name: "9th Grade"), Tag(name: "10th Grade"), Tag(name: "11th Grade"), Tag(name: "12th Grade"), Tag(name: "College Freshman"), Tag(name: "College Sophomore"), Tag(name: "College Junior"), Tag(name: "College Senior"), Tag(name: "Other")]),
        Question(name: "Schools", choices: [Tag(name: "Pinewood"), Tag(name: "Los Altos High School"), Tag(name: "Montain View High School")])
    ]
    
    @State private var multiSelection = Set<UUID>()
    
    var body: some View {
        NavigationView {
            List(selection: $multiSelection){
                ForEach(Questions) {question in
                    Section(header: Text("\(question.name)")) {
                        ForEach(question.choices) { tag in
                            Text(tag.name)
                        }
                    }
                }
            }
            .navigationTitle("Options")
            .toolbar { EditButton()}
        }
        Text("\(multiSelection.count) selections")
    }
}


struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
