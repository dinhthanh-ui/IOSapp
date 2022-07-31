//
//  WebService.swift
//  RealTimeChart
//
//  Created by Macbook Pro on 31/07/2022.
//

import Foundation
//enum NetworkError: Error {
//    case invalidURL
//    case noData
//    case decodingError
//}
class AuthService:ObservableObject {
    var valueLogin: String = ""
    var password: String = ""
    var accountName : String = ""
    @Published var isAuthenticated: Bool = false
    
    func login() async {
        guard let url = URL(string: "http://localhost:8080/api/v1/user/login")
        else{
            fatalError("Missing URL")
        }
        let body = LoginRequetBody(valueLogin: valueLogin, password: password)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        do{
            let (data,response) = try await URLSession.shared.data(for: request)
            guard(response as? HTTPURLResponse)?
                .statusCode == 200
            else{
                fatalError("Error with Login data")
            }
            let decoder = JSONDecoder()
            let decoderData =  try decoder.decode(LoginResponse.self, from: data)
            let token = decoderData.errorData.accessToken
            let defaults = UserDefaults.standard
            defaults.setValue(token, forKey: "jwt")
            DispatchQueue.main.sync {
                self.isAuthenticated = true
            }
        }catch{
            print("Error Login : \(error)")
        }
    }
    func getAllAccounts() async {
        guard let url = URL(string: "http://localhost:8080/api/v1/user/account")
        else{
            fatalError("Missing URL")
        }
        var request = URLRequest(url: url)
        do{
            let defaults = UserDefaults.standard
            guard let token = defaults.string(forKey: "jwt") else {
                return
            }
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            let (data,response) = try await URLSession.shared.data(for: request)
            guard(response as? HTTPURLResponse)?
                .statusCode == 200
            else{
                fatalError("Error with Login data")
            }
           
            let decoder = JSONDecoder()
            let tokenData =  try decoder.decode(Account.self, from: data)
            accountName = tokenData.errorData.fullName
            DispatchQueue.main.sync {
                self.isAuthenticated = true
            }
        }catch{
            print("Error Login Account : \(error)")
        }
       
        
        
        
        
        
        
        
        
        
    }
}
