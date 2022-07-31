//
//  LoginAndRegisterView.swift
//  RealTimeChart
//
//  Created by Macbook Pro on 30/07/2022.
//

import SwiftUI
import Firebase
//class FirebaseManager: NSObject {
//
//    let auth: Auth
//
//    static let shared = FirebaseManager()
//
//    override init() {
//        FirebaseApp.configure()
//
//        self.auth = Auth.auth()
//
//        super.init()
//    }
//
//}
struct LoginAndRegisterView: View {
    @State private var isLoginMode = true
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var confirmPassword:String = ""
    @StateObject var authControler = AuthService()
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 20){
                    Picker(selection: $isLoginMode) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }label: {
                        Text("Picker Here")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Group{
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Paswrod", text: $password)
                        if !isLoginMode {
                            SecureField("Confirm Password", text: $confirmPassword)
                            Button{
                                
                            }label: {
                                
                                Image(systemName: "person.fill")
                                    .font(.system(size: 64))
                                    .padding(20)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .border(.black, width: 4)
                    .cornerRadius(20)
                    
                    Button{
                        handleLogin()
                    }label: {
                        HStack{
                            Spacer()
                            Text(isLoginMode ? "Login":"Crete Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }
                        .background(Color.blue)
                        .cornerRadius(15)
                    }
                }
                .padding()
            }
            .background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
            .navigationTitle(isLoginMode ? "Log In":"Create Account")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        if authControler.isAuthenticated == true{
            Text("xin chao ban \(authControler.accountName)")
                .foregroundColor(Color.yellow)
        }
        Button{
            handleAccount()
        }label: {
            Text("get account")
                .foregroundColor(.black)
                .padding(.vertical, 10)
                .font(.system(size: 14, weight: .semibold))
        }
    }
    private func handleAccount(){
        Task{
            await handleGetAccount()
        }
    }
    private func handleGetAccount() async {
        await authControler.getAllAccounts()
    }
    private func handleLogin(){
        Task {
           await handleAction()
        }
    }
    private func handleAction() async {
        if isLoginMode{
            authControler.valueLogin = email;
            authControler.password = password
            if email == ""  && password == "" {
                print("vui long nhap thong tin")
            }else{
                await authControler.login()
            }
        }
        else{
            if password == confirmPassword {
                print("regsiter")
                
            }
        }
    }
}


struct LoginAndRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        LoginAndRegisterView()
    }
}
