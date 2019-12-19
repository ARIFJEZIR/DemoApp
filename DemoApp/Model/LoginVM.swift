//
//  LoginVM.swift
//  DemoApp
//
//  Created by Arif on 17/12/19.
//  Copyright © 2019 GSM Plus Infotech. All rights reserved.
//

import Foundation


struct LoginModel{
    
    var data : LoginData!
    var message : String!
    var status : Int!
    var token : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["data"] as? [String:Any]{
            data = LoginData(fromDictionary: dataData)
        }
        message = dictionary["message"] as? String ?? ""
        status = dictionary["status"] as? Int ?? 0
        token = dictionary["token"] as? String ?? ""
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if data != nil{
            dictionary["data"] = data.toDictionary()
        }
        if message != nil{
            dictionary["message"] = message
        }
        if status != nil{
            dictionary["status"] = status
        }
        if token != nil{
            dictionary["token"] = token
        }
        return dictionary
    }
    
}
struct LoginData{
    
    var lname : String!
    var email : String!
    var fName : String!
    var id : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        lname = dictionary["Lname"] as? String ?? ""
        email = dictionary["email"] as? String ?? ""
        fName = dictionary["fName"] as? String ?? ""
        id = dictionary["id"] as? Int ?? 0
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if lname != nil{
            dictionary["Lname"] = lname
        }
        if email != nil{
            dictionary["email"] = email
        }
        if fName != nil{
            dictionary["fName"] = fName
        }
        if id != nil{
            dictionary["id"] = id
        }
        return dictionary
    }
    
}
