//
//  MainPageVC.swift
//  DemoApp
//
//  Created by Arif on 13/12/19.
//  Copyright © 2019 GSM Plus Infotech. All rights reserved.
//

import UIKit

class MainPageVC: UIViewController {

    @IBOutlet var btnSignUp: UIButton!
    
    @IBOutlet var btnSignIn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSignUp.layer.cornerRadius = 15
        self.btnSignIn.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickSignUp(_ sender: UIButton) {
        let signUpVC = STORYBOARDMAIN.instantiateViewController(withIdentifier: "SignUpVC") as!  SignUpVC
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func clickSignIn(_ sender: Any) {
        let loginVC = STORYBOARDMAIN.instantiateViewController(withIdentifier: "LoginPageVC") as!  LoginPageVC
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
}
