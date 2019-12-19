//
//  SignUpVC.swift
//  DemoApp
//
//  Created by Arif on 13/12/19.
//  Copyright © 2019 GSM Plus Infotech. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SignUpVC: UIViewController {

    @IBOutlet var txtFirstName: SkyFloatingLabelTextField!
    
    @IBOutlet var txtLastName: SkyFloatingLabelTextField!
    
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var txtConfirmPassword: SkyFloatingLabelTextField!
    @IBOutlet var txtPassword: SkyFloatingLabelTextField!
    @IBOutlet var txtEmail: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.btnSubmit.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickSubmit(_ sender: Any) {
        if checkValidation(){
            if txtPassword.text == txtConfirmPassword.text {
        let urlString = SignUpAPI.signUpURL
        let header = ["x-auth-token":USERDEFAULTS.getAuthToken()]
        let parameters = ["":""]
        APIManager.shared.postcall(urlString: urlString, inputParams: parameters, headers: header) { (response, error) in
        if error == nil {
            self.showAlert("Sucessfully Signed Up")
            APPDELEGATE.updateLoginVC()
            print("Add Your Profile")
        } else{
            self.showAlert(error!.localizedDescription)
            }
        }
            }else{
                   showAlert("Confirm password not correct ")
            }
    }
    }
    func getLeadParameters() -> [String: Any]{
        
        let parameters : [String: Any] = [
            "fname" : txtFirstName.text!,
            "Lname" : txtLastName.text!,
            "email" : txtEmail.text!,
            "Password" : txtPassword.text!,
        ]
        return parameters
    }
    
    func checkValidation() -> Bool{
        if (self.txtFirstName.text?.isEmpty)!{
            showAlert("Please enter first name")
            return false
        }else if (txtLastName.text?.isEmpty)!{
            showAlert("Please enter last name")
            return false
        }else if (txtEmail.text?.isEmpty)!{
            showAlert("Please enter email address")
            return false
        }else if (txtPassword.text?.isEmpty)!{
            showAlert("Please enter password")
            return false
        }else if (txtPassword.text!.count < 6){
            showAlert("Psaaword should be more than 5 characters")
            return false
        } else if (txtConfirmPassword.text?.isEmpty)!{
            showAlert("Please enter confirm password")
            return false
        }
        return true
    }
    
    @IBAction func goBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
}
extension SignUpVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFirstName{
            txtLastName.becomeFirstResponder()
        }else if textField == txtLastName{
            txtEmail.becomeFirstResponder()
        }else if textField == txtEmail{
            txtPassword.becomeFirstResponder()
        }else if textField == txtPassword{
            txtConfirmPassword.becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}

