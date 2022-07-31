//
//  Login.swift
//  RealTimeChart
//
//  Created by Macbook Pro on 31/07/2022.
//

import Foundation
struct LoginRequetBody: Codable{
    let valueLogin : String
    let password: String
}
struct LoginResponse : Decodable {
    var errorData: Data
    let errorMessage : String
    
    struct Data: Decodable {
        var id : UUID{
            UUID()
        }
        var fullName : String
        var accessToken : String
        var groupWithRoles: Group
        struct Group : Decodable{
            var id : UUID{
                UUID()
            }
            var name : String
            var description : String
            var Roles : [Role]
            struct Role : Decodable, Identifiable{
                var id : UUID{
                    UUID()
                }
                var url : String
                var description : String
            }
        }
    }
}
struct Account: Decodable {
    let errorMessage : String
    let errorCode : Int
    var errorData: Data
    
    struct Data: Decodable {
        var id : UUID{
            UUID()
        }
        var fullName : String
    }
}

