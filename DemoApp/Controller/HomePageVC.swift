//
//  HomePageVC.swift
//  DemoApp
//
//  Created by Arif on 14/12/19.
//  Copyright © 2019 GSM Plus Infotech. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController {
    @IBOutlet var txtLoginName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       txtLoginName.text = USERDEFAULTS.getEmailId()
        getHomePageData()
    }
    @IBAction func clickLogOut(_ sender: Any) {
        USERDEFAULTS.clearLoginDetails()
        APPDELEGATE.MainVC()
    }
    
    func getHomePageData(){
         let header = ["x-auth-token":USERDEFAULTS.getAuthToken()]
        APIManager.shared.getRequest(stringApi: HomeAPI.homeURL, headers: header){
            (response, error) in
            if error == nil {
                let home = Home(fromDictionary: (response as? [String: Any])!)
                self.txtLoginName.text = home.data.lname
                self.dismissProgress()
            }else {
                self.showAlert(error!.localizedDescription)
            }
        }
        
        
    }

}
