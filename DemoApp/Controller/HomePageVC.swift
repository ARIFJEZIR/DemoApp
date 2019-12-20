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
       // USERDEFAULTS.clearLoginDetails()
            let dialogMessage = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                  APPDELEGATE.updateLoginVC()
                let domain = Bundle.main.bundleIdentifier!
                USERDEFAULTS.removePersistentDomain(forName: domain)
                USERDEFAULTS.synchronize()
                
            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                print("Cancel button tapped")
            }
            
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            self.present(dialogMessage, animated: true, completion: nil)
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
