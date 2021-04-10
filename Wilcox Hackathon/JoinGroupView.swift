//
//  JoinGroupView.swift
//  Wilcox Hackathon
//
//  Created by Rosalie Wessels on 4/9/21.
//

import SwiftUI

struct JoinGroupView: View {
    
    @State var groupCode: String = ""
    
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
                
                HStack{
                    NavigationLink(destination: FormView()) {
                        Image(systemName: "doc.badge.gearshape.fill").foregroundColor(Color.black)
                        Text("Redo Your Recommendations").foregroundColor(Color.black)
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
        print("add group into groups in firebase") // this function uses the name. a different one will use a code? maybe? this is that different one? 
    }
}

struct SuggestedGroupBox: View {
    @State var groupName: String
    var body: some View {
        HStack {
            Text(groupName).fontWeight(.heavy)
            
            Button(action: {joinGroup()}){
                Image(systemName: "plus.circle.fill").foregroundColor(Color.black)
                Text("join").foregroundColor(Color.black)
            }
            
            HStack {
                // should this take the user to a different page or just show like an alert?
                NavigationLink(destination: ContentView()) {
                    Image(systemName: "magnifyingglass.circle.fill").foregroundColor(Color.black)
                    Text("info").foregroundColor(Color.black)
                }
            }
        }
    }
    
    func joinGroup() {
        print("add group into groups in firebase") // this function uses the name. a different one will use a code? maybe?
    }
}

struct JoinGroupView_Previews: PreviewProvider {
    static var previews: some View {
        JoinGroupView()
    }
}
