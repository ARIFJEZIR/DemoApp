//
//  NSObjectExtension.swift
//  MyProof
//
//  Created by Athi S on 01/07/19.
//  Copyright © 2019 gsmplus. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Reachability
import SVProgressHUD

extension NSObject{
    
    var BaseURL: String{
        if let configuration = Bundle.main.infoDictionary!["Configuration"] as? String{
            if let fileUrl = Bundle.main.url(forResource: "Environments", withExtension: "plist"),
                let data = try? Data(contentsOf: fileUrl) {
                if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
                    if let environment = result![configuration] as? [String: Any] {
                        return environment["baseServerURLString"] as? String ?? ""
                    }
                }
            }
        }
        return ""
    }
    
    public var className: String {
        return type(of: self).className
    }
    
    public static var className: String {
        return String(describing: self)
    }
    
    //MARK: - Get topviewcontroller
    public func topMostViewController() -> UIViewController {
        return self.topMostViewController(withRootViewController: (UIApplication.shared.keyWindow?.rootViewController!)!)
    }
    
    public func topMostViewController(withRootViewController rootViewController: UIViewController) -> UIViewController {
        if (rootViewController is UITabBarController) {
            let tabBarController = (rootViewController as! UITabBarController)
            return self.topMostViewController(withRootViewController: tabBarController.selectedViewController!)
        }
        else if (rootViewController is UINavigationController) {
            let navigationController = (rootViewController as! UINavigationController)
            return self.topMostViewController(withRootViewController: navigationController.visibleViewController!)
        }
        else if rootViewController.presentedViewController != nil {
            let presentedViewController = rootViewController.presentedViewController!
            return self.topMostViewController(withRootViewController: presentedViewController)
        }
        else {
            return rootViewController
        }
        
    }
    
    //MARK: - Check Internet Connection
    func hasInternet() -> Bool {
        let reachability = try! Reachability.init()
        let networkStatus = reachability.connection.description
        return (networkStatus != "No Connection")
    }
    
    //MARK: - Show No Internet Alertview
    func showInternetAlertView() {
        if(topMostViewController().isKind(of: UIAlertController.self)){
            return
        }
        let alertMessage = UIAlertController(title: "Internet unavailable", message: "Please check your network connection", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertMessage.addAction(okAction)
        topMostViewController().present(alertMessage, animated: true, completion: nil)
    }
    //MARK: - Show Alertview
    func showAlert(_ title: String ) {
        let alertMessage = UIAlertController(title:"MyProof" , message: title, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertMessage.addAction(okAction)
        topMostViewController().present(alertMessage, animated: true, completion: nil)
    }
    
    func permissionAlert(title: String)
    {
        let alertController = UIAlertController(title:"MyProof" , message: title, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { UIAlertAction in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        topMostViewController().present(alertController, animated: true, completion: nil)
    }
    
    func LocationAlert(){
        let alertController = UIAlertController (title: "Do You Want to On Location Service To share Location ?", message: "Go to Settings -> Privacy -> Location Service?", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
            
        }
        
        alertController.addAction(settingsAction)
        
        topMostViewController().present(alertController, animated: true, completion: nil)
        
    }
    
    func DLog(message: Any, function: String = #function,  file: String = #file, line: Int = #line) {
        #if DEBUG
        print("[\(file) - \(function) - \(line)]: \(message)")
        #endif
    }
    
    /*
     * Print the retrived objects from service in Json format.
     */
    public func jsonFormatterDict (inputData:Any) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: inputData, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            if let jString = String(data: jsonData, encoding: .utf8) {
                return jString
            }
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
    
    func addStarToPlaceHolder(name: String) -> NSMutableAttributedString{
        let attrString  = NSMutableAttributedString()
        let font = UIFont(name: "Lato-Regular", size: 15.0)!
        let fontSuper = UIFont(name: "Lato-Regular", size: 15.0)!
        let title = NSAttributedString(string: name, attributes: [NSAttributedString.Key.font :font])
        let sectitle = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.font :fontSuper, NSAttributedString.Key.baselineOffset :0, NSAttributedString.Key.foregroundColor: UIColor.red])
        attrString.append(title)
        attrString.append(sectitle)
        return attrString
    }
    func getStrikeOutText(_ text: String) -> NSMutableAttributedString{
        let attrString  = NSMutableAttributedString(string: text)
        attrString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attrString.length))
        return attrString
    }
    
    func getDateFormatter() -> DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")//NSTimeZone(name: "UTC") as TimeZone!
        return dateFormatter
    }
    func getUTCFOrmat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: date)
    }
    
    func getMonthDateYearString(_ time: String) -> String{
        let timeFormatter = getDateFormatter()
        let utcDate = timeFormatter.date(from: time)
        timeFormatter.dateFormat = "MMM dd, yyyy"
        timeFormatter.timeZone = TimeZone.current
        return timeFormatter.string(from: utcDate!)
    }
    
    func getTimeString(_ time: String) -> String{
        let timeFormatter = getDateFormatter()
        let utcDate = timeFormatter.date(from: time)
        timeFormatter.dateFormat = "hh:mma"
        timeFormatter.timeZone = TimeZone.current
        return timeFormatter.string(from: utcDate!)
    }
    
    func getYearMonthDateString(_ date: Date) -> String{
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        timeFormatter.timeZone = TimeZone.current
        return timeFormatter.string(from: date)
    }
    func getDateMonthYear(_ date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "dd-MMM-yyyy"
        timeFormatter.timeZone = TimeZone.current
        return timeFormatter.string(from: date)
    }
    func getTimeDateString(time: Date) -> String{
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        return timeFormatter.string(from: time)
    }
    func getOnlyYear(_ date: Date) -> String{
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy"
        timeFormatter.timeZone = TimeZone.current
        return timeFormatter.string(from: date)
    }
    
    func getTimeDate(time: String) -> Date{
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        return timeFormatter.date(from: time)!
    }
    
    func getRecordDateTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    func getImageDateTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy h:mm a"
       dateFormatter.timeZone = TimeZone.current
         dateFormatter.locale = Locale.current
        return dateFormatter.string(from: date)
    }
    
    func getYearMonth(_ date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM"
        timeFormatter.timeZone = TimeZone.current
        timeFormatter.locale = Locale.current
        return timeFormatter.string(from: date)
        
        
    }
   
    
    // MARK: PROGRESS
    func showProgress() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            SVProgressHUD.setForegroundColor(UIColor.appTextBlue)
            SVProgressHUD.setBackgroundColor(UIColor.white)
            SVProgressHUD.show()
            SVProgressHUD.setDefaultMaskType(.black)
        }
    }
    
    func dismissProgress() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            //SVProgressHUD.dismiss()
            SVProgressHUD.popActivity()
        }
    }
}

extension NSObject {
    
    //MARK: - Check response as Dictionary
    func isStatusOK(json: Any?,isShowToast:Bool = true) -> (isOk:Bool, info:[String:Any]) {
        guard let info = json as? [String: Any] else {
            return (false,[:])
        }
        var status = false
        if let errorStatus = info["status"] as? String {
            status = (errorStatus == "success" || errorStatus == "sucess" || (info["code"] as? Int == 200))
            if status {
                return (status,info)
            }
        }
        if isShowToast && !status {
            let errormsg = info["message"] as? String ?? "Failed to get response"
            showAlert(errormsg)
            return (false,info)
        }
        else{
            return (false,info)
        }
    }
    
   
}
