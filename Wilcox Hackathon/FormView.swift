//
//  FormView.swift
//  Wilcox Hackathon
//
//  Created by Rosalie Wessels on 4/9/21.
//

import SwiftUI

struct FormView: View {
    @State var classes: String = ""
    var body: some View {
        question(label: "Classes", placeholder: "What classes are you taking")
    }
}

struct question: View {
    @State var label: String
    @State var placeholder: String
    @State var answer: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text(label).font(.headline)
            TextField(placeholder, text: $answer)
                .padding(.all)
                .cornerRadius(5)
                .border(Color(UIColor.separator))
        }
        .padding(.horizontal, 15)
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
