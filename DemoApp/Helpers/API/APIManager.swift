//
//  APIManager.swift
//  DemoApp
//
//  Created by Arif on 14/12/19.
//  Copyright © 2019 GSM Plus Infotech. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD
import Reachability

typealias CompletionCallBack  = (_ response: Any? , _ error:Error?) -> Void


class APIManager: NSObject {
    static let shared = APIManager()
    
    
    func login(userParams:[String:Any]?, completion callback:@escaping CompletionCallBack) {
        self.postcall(urlString: LoginAPI.loginURL, inputParams: userParams) { (response, error) in
            callback(response, error)
        }
        
    }
    
    
    func postcall(urlString: String, inputParams:[String:Any]? = nil, headers:[String:String]? = nil,isProgress: Bool = true, isResponseString:Bool = false, isJsonCoding:Bool = true, callback: @escaping CompletionCallBack){
        print("API:=> \(urlString)?\(jsonFormatterDict (inputData:inputParams ?? [:]))")
        UIApplication.shared.keyWindow?.endEditing(true)
        
        if !hasInternet(){
            showInternetAlertView()
            return
        }
        if isProgress{
            self.showProgress()
        }
        
        let enCoding:ParameterEncoding = isJsonCoding ? JSONEncoding.default : URLEncoding.default
        if (!isResponseString){
            Alamofire.request(urlString, method: .post, parameters: inputParams, encoding: enCoding, headers: headers).responseJSON {
                (responseFeed:DataResponse<Any>) in
                
                do {
                    
                    
                    let apiResponse:Any = try JSONSerialization.jsonObject(with: responseFeed.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    print("Respnse: \(apiResponse)")
                    callback(apiResponse, responseFeed.error)

                }catch{
                    print(error.localizedDescription)
                    callback([:], error)
                }
            }
        }else {
            Alamofire.request(urlString, method: .post, parameters: inputParams, encoding: enCoding, headers: headers).responseString {
                (responseFeed:DataResponse<String>) in
                if responseFeed.result.isSuccess && responseFeed.response?.statusCode == 200 {
                    callback(responseFeed.result.value, responseFeed.error)

                }
                print(responseFeed)
            }
        }
    }
    func getRequest(stringApi: String,parameters: [String: Any]? = nil, headers: [String: String], isProgress: Bool = true, callback: @escaping CompletionCallBack){
        if(hasInternet()){
            if isProgress{
                self.showProgress()
            }
            print("API:=> \(stringApi)?\(jsonFormatterDict (inputData:parameters ?? [:]))?\(jsonFormatterDict (inputData:headers ?? [:] ))")
            Alamofire.request(stringApi, method: .get, parameters: parameters, headers: headers).responseJSON{ (response) in
                print(response)
                do{
                    let apiResponse: Any = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)
                    print("response: \(apiResponse)")
                    callback(apiResponse as AnyObject?, response.error)
                    self.dismissProgress()
                }
                catch{
                    callback([:] as AnyObject, response.error)
                    self.dismissProgress()
                }
            }
        }
        else{
            showInternetAlertView()
        }
    }
    
    
   
    
}

extension NSObject {
    
    
    
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
    func hasInternet() -> Bool {
        let reachability = try! Reachability.init()
        let networkStatus = reachability.connection.description
        return (networkStatus != "No Connection")
    }
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
        let alertMessage = UIAlertController(title:"MyApp" , message: title, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertMessage.addAction(okAction)
        topMostViewController().present(alertMessage, animated: true, completion: nil)
    }
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
    
    
    func showProgress() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            SVProgressHUD.setForegroundColor(UIColor.blue)
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
