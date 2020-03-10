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
    func getCurrentExperience() {
        self.isLoading = true
        let params = [
            "page_no": self.pgNo,
            ] as [String : Any]
        homeVM.getExperience(params:params, isProgress: isProgress) { (status) in
            if status {
                if self.pgNo == 1{
                    self.experience = self.homeVM.experience
                }
                else{
                     self.experience += self.homeVM.experience
                }
                self.tableView.reloadData()
                    self.tableView.tableFooterView = UIView()
                if !self.experience.isEmpty &&  self.pgNo == 1{
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
//                else{
//                    self.tableView.scrollToBottom()
//                }
                if self.pgNo <= self.homeVM.home.totalPage {
                                           self.pgNo += 1
                                           DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                               self.isLoading = false
                                           }
                                       }else{
                                           self.isLoading = true
                                       }
                }
            
            
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
    
    extension HomePageVC {
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (roundf(Float(scrollView.contentOffset.y)) == roundf(Float(scrollView.contentSize.height) - Float(scrollView.frame.size.height))) {
            if(!isLoading){
                let activityindicator = UIActivityIndicatorView(style: .gray)
                let footerview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 40))
                activityindicator.center = footerview.center
                footerview.addSubview(activityindicator)
                activityindicator.color = UIColor.white
                activityindicator.startAnimating()
                self.tableView.tableFooterView = footerview
                self.tableView.tableFooterView!.center = footerview.center
                self.tableView.scrollRectToVisible(self.tableView.convert((self.tableView.tableFooterView?.bounds)!, from: self.tableView.tableFooterView) , animated: true)
                if self.pgNo <= self.homeVM.home.totalPage {
                    isProgress = false
                } else {
                     activityindicator.stopAnimating()
                }
               
            }
        }
        
    }
    }

}
