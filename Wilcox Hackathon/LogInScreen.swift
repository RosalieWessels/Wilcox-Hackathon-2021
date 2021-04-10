//
//  LogInScreen.swift
//  Wilcox Hackathon
//
//  Created by Rosalie Wessels on 4/9/21.
//

import SwiftUI

struct LogInScreen: View {
    var body: some View {
        Text("Log In")
            .font(.largeTitle)
        
        NavigationLink(destination: MainView()) {
            Text("Submit")
        }
            
    }
    
    func logIn() {
        
    }
}

struct LogInScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogInScreen()
    }
}
