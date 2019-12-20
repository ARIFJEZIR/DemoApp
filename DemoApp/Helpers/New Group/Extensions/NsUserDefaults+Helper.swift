//
//  NsUserDefaults+Helper.swift
//  DemoApp
//
//  Created by Arif on 14/12/19.
//  Copyright © 2019 GSM Plus Infotech. All rights reserved.
//

import Foundation


extension UserDefaults {
    
    
    struct Userdefaults {
    static let login = "logininfo"
    static let authToken = "authToken"
    static let emailID = "EmailID"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let userID = "UserID"
    static let password = "Password"
    
    }
    
    func saveLoginDetails(logininfo: [String: Any]){
        if logininfo.count > 0 {
            self.set(logininfo, forKey: Userdefaults.login)
            self.synchronize()
        }
    }
    
    func getLoggedUserDetails() -> [String: AnyObject] {
        if let _ = self.object(forKey: Userdefaults.login) {
            return self.object(forKey: Userdefaults.login) as! [String: AnyObject]
        }
        return [:]
    }
    
    func clearLoginDetails() {
        self.removeObject(forKey: Userdefaults.emailID)
        self.removeObject(forKey: Userdefaults.password)
        self.removeObject(forKey: Userdefaults.login)
        self.removeObject(forKey: Userdefaults.authToken)
        self.removeObject(forKey: Userdefaults.userID)
      
    }
    func loggedIn() -> Bool {
        let userDetails: [String : AnyObject] = getLoggedUserDetails()
        if userDetails.count > 0 {
            return true
        }
        return false
    }
    func saveAuthToken(token: String){
        self.set(token, forKey: Userdefaults.authToken)
    }
    func getAuthToken() -> String{
        if let _ = self.object(forKey: Userdefaults.authToken) {
            return self.object(forKey: Userdefaults.authToken) as! String
        }
        return ""
    }
    func saveEmailID(emailID : String)
    {
        self.set(emailID, forKey: Userdefaults.emailID)
    }
    
    
    func getEmailId() -> String {
        if let _ = self.object(forKey: Userdefaults.emailID) {
            return self.object(forKey: Userdefaults.emailID) as! String
        }
        return ""
    }
    
    
    func saveFirstName(studentName : String)
    {
        self.set(studentName, forKey: Userdefaults.firstName)
    }
    
    func getFirstName() -> String
    {
        if let _ = self.object(forKey: Userdefaults.firstName) {
            return self.object(forKey: Userdefaults.firstName) as! String
        }
        return ""
    }
    
    func saveLastName(staffName : String)
    {
        self.set(staffName, forKey: Userdefaults.lastName)
    }
    func getLastName() -> String
    {
        if let _ = self.object(forKey: Userdefaults.lastName) {
            return self.object(forKey: Userdefaults.lastName) as! String
        }
        return ""
    }
    func getUserID() -> String
    {
        if let _ = self.object(forKey: Userdefaults.userID) {
            return self.object(forKey: Userdefaults.userID) as! String
        }
        return ""
    }
    
    func savePassword(pass : String)
    {
        self.set(pass, forKey: Userdefaults.password)
    }
    
    func getPassword() -> String
    {
        if let _ = self.object(forKey: Userdefaults.password) {
            return self.object(forKey: Userdefaults.password) as! String
        }
        return ""
    }
    func saveUserID(userID : Int){
        self.set(userID, forKey: Userdefaults.userID)
    }
    
}
