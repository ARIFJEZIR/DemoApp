//
//  SignUP.swift
//  DemoApp
//
//  Created by Arif on 17/12/19.
//  Copyright © 2019 GSM Plus Infotech. All rights reserved.
//

import Foundation

struct SignUp{
    
    var data : SignUpData!
    var message : String!
    var status : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["data"] as? [String:Any]{
            data = SignUpData(fromDictionary: dataData)
        }
        message = dictionary["message"] as? String
        status = dictionary["status"] as? Int
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
        return dictionary
    }
    
}
struct SignUpData{
    
    var lname : String!
    var email : String!
    var fname : String!
    var userId : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        lname = dictionary["Lname"] as? String
        email = dictionary["email"] as? String
        fname = dictionary["fname"] as? String
        userId = dictionary["userId"] as? Int
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
        if fname != nil{
            dictionary["fname"] = fname
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        return dictionary
    }
    
}
