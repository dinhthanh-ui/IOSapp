//
//  Login.swift
//  RealTimeChart
//
//  Created by Macbook Pro on 31/07/2022.
//

import Foundation
class AuthController: ObservableObject {
    var valueLogin: String = ""
    var password: String = ""
    @Published var isAuth: Bool = false
    
    func Login(){
//        let defalts = UserDefaults.standard
//        print("check data: \(defalts)")
        
//        AuthService().login(valueLogin: valueLogin, password: password) { result in
//            switch result {
//            case .success(let token): defalts.setValue(token, forKey: "jwt")
//                DispatchQueue.main.async {
//                    self.isAuth = true
//                }
//            case .failure(let error): print(error.localizedDescription)
//            }
//        }
    }
}
