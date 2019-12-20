//
//  LoginPageVC.swift
//  DemoApp
//
//  Created by Arif on 13/12/19.
//  Copyright © 2019 GSM Plus Infotech. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginPageVC: UIViewController {

    @IBOutlet var txtUserName: SkyFloatingLabelTextField!
    
    @IBOutlet var txtPassword: SkyFloatingLabelTextField!
    
    @IBOutlet var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnLogin.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickLogin(_ sender: Any) {
        self.view.endEditing(true)
        if checkValidate() {
            USERDEFAULTS.savePassword(pass: txtPassword.text!)
            USERDEFAULTS.saveEmailID(emailID: txtUserName.text!)
            let params = ["email": txtUserName.text!,
                          "Password": txtPassword.text!]
            APIManager.shared.login(userParams: params) {
                (response ,error) in
                if error == nil {
                     let login = LoginModel(fromDictionary: (response as? [String: Any])!)
                    USERDEFAULTS.saveLoginDetails(logininfo: login.data.toDictionary())
                    USERDEFAULTS.saveAuthToken(token: login.token)
                    USERDEFAULTS.saveEmailID(emailID: login.data.email)
                    USERDEFAULTS.saveUserID(userID: login.data.id)
                    USERDEFAULTS.saveFirstName(studentName: login.data.fName)
                    USERDEFAULTS.saveLastName(staffName: login.data.lname)
                    APPDELEGATE.HomeVC()
                }else{
                    self.showAlert(error!.localizedDescription)
                }
            }
            APPDELEGATE.HomeVC()
        }
    }
    
    @IBAction func goSignUp(_ sender: Any) {
        let signUpVC = STORYBOARDMAIN.instantiateViewController(withIdentifier: "SignUpVC") as!  SignUpVC
        self.present(signUpVC, animated: true,completion: nil)
    }
    
    func checkValidate() -> Bool {
        if txtUserName.text!.isEmpty {
            self.showAlert("Please enter your UserName")
            return false
        } else if txtPassword.text!.isEmpty {
            self.showAlert("Please enter your Password")
            return false
        }
        
        return true
        
    }
    
}
