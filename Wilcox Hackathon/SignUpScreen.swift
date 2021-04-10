//
//  SignUpScreen.swift
//  Wilcox Hackathon
//
//  Created by Rosalie Wessels on 4/9/21.
//

import SwiftUI


struct SignUpScreen: View {
    
    @ObservedObject var model : ModelData
    
    var body: some View {
        ZStack {
            VStack {
                
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("School Email")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    TextField("School Email...", text: $model.email_SignUp)
                        .padding(.vertical)
                    
                    Text("Password")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    SecureField("Password...", text: $model.password_SignUp)
                        .padding(.vertical)
                    
                    Text("Re-enter Password")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    SecureField("Re-enter Password...", text: $model.reEnterPassword)
                        .padding(.vertical)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: model.signUp) {
                    Text("Submit")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color("DarkGray"))
                .cornerRadius(20)
                
            }
            
            VStack() {
                HStack {
                    Spacer()
                    Button(action: {
                        model.isSignUp.toggle()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.title)
                    }
                    .padding()
                    
                    if model.isLoading {
                        LoadingView()
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $model.alert, content: {
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok"), action: {
                
                if model.alertMsg == "Email verification has been sent!"{
                    model.isSignUp.toggle()
                    model.email_SignUp = ""
                    model.password_SignUp = ""
                    model.reEnterPassword = ""
                }
                
            }))
        })
            
    }

}

