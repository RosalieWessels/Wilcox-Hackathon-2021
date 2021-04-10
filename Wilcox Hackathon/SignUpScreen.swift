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
                    .font(.system(size: 50))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .shadow(radius:3)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("School Email")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .shadow(radius:3)
                    
                    TextField("School Email...", text: $model.email_SignUp)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 0.5))
                        .cornerRadius(5.0)
                        .shadow(radius:3)
                    
                    Text("Password")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .shadow(radius:3)
                    
                    SecureField("Password...", text: $model.password_SignUp)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 0.5))
                        .cornerRadius(5.0)
                        .shadow(radius:3)
                    
                    Text("Re-enter Password")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .shadow(radius:3)
                    
                    SecureField("Re-enter Password...", text: $model.reEnterPassword)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 0.5))
                        .cornerRadius(5.0)
                        .shadow(radius:3)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: model.signUp) {
                    NavigationLink(destination: FormView()) {
                        Text("Submit")
                            .foregroundColor(.black)
                            .font(Font.custom("ArialRoundedMTBold", size: 25))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius:3)
                    }
                }
                .padding()
                
                
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
        .background(Image("background8").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea())
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

