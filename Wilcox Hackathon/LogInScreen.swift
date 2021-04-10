//
//  LogInScreen.swift
//  Wilcox Hackathon
//
//  Created by Rosalie Wessels on 4/9/21.
//

import SwiftUI
import Firebase
import Combine


struct FullLoginView : View {
    
    @AppStorage("log_Status") var status = DefaultStatus.status
    @StateObject var model = ModelData()
    
    var body: some View {
        
        ZStack {
            if status == true {
                
//                VStack {
//                    Text("Logged in as \(Auth.auth().currentUser?.email ?? "")")
//
//
//                    Button(action: model.logOut) {
//                        Text("Log out")
//                    }
//                }
                MainView()
            }
            else {
                LogInScreen(model: model)
            }
        }.onAppear(perform: {
            checkStatus()
        })
        
    }
    
    func checkStatus() {
        if status == true {
            print("LOGGED IN IN DIFFERENT VIEW")
        }
    }
}

struct LogInScreen: View {
    
    @ObservedObject var model : ModelData
    
    var body: some View {
        ZStack {
            VStack {
                
                Text("Log In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("School Email")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    TextField("School Email...", text: $model.email)
                        .padding(.vertical)
                    
                    Text("Password")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    SecureField("Password...", text: $model.password)
                        .padding(.vertical)
                }
                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    Text("Don't have an account yet?")
                        .font(.subheadline)
                    
                    Button(action: {model.isSignUp.toggle()}) {
                        Text("Sign Up Now")
                            .fontWeight(.bold)
                    }
                }
                
                Button(action: model.resetPassword) {
                    Text("Forgot password?")
                }
                
                Spacer()
                
                Button(action: model.login) {
                    Text("Submit")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color("DarkGray"))
                .cornerRadius(20)

                
            }
            
            if model.isLoading {
                LoadingView()
            }
        }
        .fullScreenCover(isPresented: $model.isSignUp, content: {
            SignUpScreen(model: model)
        })
        //CHECK
//        .alert(isPresented: $model.isLinkSend) {
//
//            Alert(title: Text("Message"), message: Text("Password Reset Link Has Been Sent."), dismissButton: .destructive(Text("Ok")))
//
//        }
        .alert(isPresented: $model.alert, content: {
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok")))
        })
        
            
    }
    
}

//struct LogInScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        LogInScreen(model: model)
//    }
//}

class ModelData : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUp = false
    @Published var email_SignUp = ""
    @Published var password_SignUp = ""
    @Published var reEnterPassword = ""
    @Published var isLinkSend = false
    
    @Published var alert = false
    @Published var alertMsg = ""
    
    @AppStorage("log_Status") var status = DefaultStatus.status
    
    @Published var isLoading = false
    
    func resetPassword() {
        
        let alert = UIAlertController(title: "Reset Password", message: "Enter your Email to Reset Your Password", preferredStyle: .alert)
        
        alert.addTextField { (password) in
            password.placeholder = "Email"
        }
        
        let proceed = UIAlertAction(title: "Reset", style: .default) { (_) in
            if alert.textFields![0].text! != "" {
                
                withAnimation {
                    self.isLoading.toggle()
                }
                
                Auth.auth().sendPasswordReset(withEmail: alert.textFields![0].text!) { (err) in
                    
                    withAnimation {
                        self.isLoading.toggle()
                    }
                    
                    if err != nil {
                        self.alertMsg = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    self.alertMsg = "Password reset link has been sent"
                    self.alert.toggle()
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        
    }
    
    func login() {
        
        if email == "" || password == "" {
            self.alertMsg = "Please fill the text boxes"
            self.alert.toggle()
            return
        }
        
        withAnimation {
            self.isLoading.toggle()
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            
            withAnimation {
                self.isLoading.toggle()
            }
            
            if err != nil {
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            let user = Auth.auth().currentUser
            
            if !user!.isEmailVerified {
                self.alertMsg = "Please verify your email address"
                self.alert.toggle()
                
                try! Auth.auth().signOut()
                
                return
            }
            
            withAnimation {
                
                self.status = true
                print("LOGGED IN - STATUS UPDATED")
            }
            
        }
    }
    
    func signUp() {
        if email_SignUp == "" || password_SignUp == "" || reEnterPassword == "" {
            self.alertMsg = "Please fill the textboxes"
            self.alert.toggle()
            return
        }
        
        if password_SignUp != reEnterPassword {
            self.alertMsg = "Passwords do not match."
            self.alert.toggle()
            return
        }
        
        withAnimation {
            self.isLoading.toggle()
        }
        
        Auth.auth().createUser(withEmail: email_SignUp, password: password_SignUp) { (result, err) in
            
            withAnimation {
                self.isLoading.toggle()
            }
            
            if err != nil {
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            result?.user.sendEmailVerification(completion: { (err) in
                if err != nil {
                    self.alertMsg = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.alertMsg = "Email verification has been sent!"
                self.alert.toggle()
            })
            
        }
    }
    
    func logOut() {
        try! Auth.auth().signOut()
        
        withAnimation {
            self.status = false
        }
        
        email = ""
        password = ""
        email_SignUp = ""
        password_SignUp = ""
        reEnterPassword = ""
    }
}

struct LoadingView: View {
    @State var animation = false
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color.black, lineWidth: 8)
                .frame(width: 75, height: 75)
                .rotationEffect(.init(degrees: animation ? 360 : 0))
                .padding(50)
        }
        .background(Color.white)
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4).ignoresSafeArea(.all, edges: .all))
        .onAppear(perform: {
            withAnimation(Animation.linear(duration: 1)) {
                animation.toggle()
            }
        })
    }
}

enum DefaultStatus {
    static let status = false
}
