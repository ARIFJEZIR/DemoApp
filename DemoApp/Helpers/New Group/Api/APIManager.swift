//
//  APIManager.swift
//  MyProof
//
//  Created by Athi S on 01/07/19.
//  Copyright © 2019 gsmplus. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

typealias CompletionCallBack = (_ response: Any? , _ error:Error?) -> Void


class APIManager: NSObject {
    
    static let shared = APIManager()
    
    //MARK:- Login
    func login(userParams:[String:Any]?, completion callback:@escaping CompletionCallBack) {
            self.postcall(urlString: LoginAPI.loginURL, inputParams: userParams) { (response, error) in
                callback(response, error)
            }
        
        }
        
    
    //MARK:- Update profile
    func updateImageandVoice(stringAPI: String, uploads:[FileUpload], params: [String: Any], headers: [String: String], completion callback:@escaping CompletionCallBack){
        postFileRequestwithHeader(stringApi:stringAPI, parameters: params as [String : AnyObject], uploads: uploads, headers: headers){ (response, error) in
            callback(response, error)
        }
    }
    
    func updateMedia(stringAPI: String, uploads:[FileUpload], params: [String: Any], headers: [String: String], completion callback:@escaping CompletionCallBack){
        postMediaFileRequest(stringApi:stringAPI, parameters: params as [String : AnyObject], uploads: uploads, headers: headers){ (response, error) in
            callback(response, error)
        }
    }
    func updateVoiceRecord(stringAPI: String, uploads:[VoiceUpload], params: [String: Any], headers: [String: String], completion callback:@escaping CompletionCallBack) {
        postVoiceRequestwithHeader(stringApi:stringAPI, parameters: params as [String : AnyObject], uploads: uploads, headers: headers){ (response, error) in
            callback(response, error)
        }
        
    }
    
    
    
    func updateInvitedUserDetails(stringAPI: String, params: [String: Any]? = nil, headers: [String: String], completion callback:@escaping CompletionCallBack){
        self.putRequest(stringApi: stringAPI, parameters: params, headers: headers) { (response, error) in
            callback(response, error)
        }
    }
    
    func updateExpDetails(stringAPI: String, params: [String: Any]? = nil, headers: [String: String], completion callback:@escaping CompletionCallBack){
        self.postcall(urlString: stringAPI, inputParams: params,headers:headers) { (response, error) in
            callback(response, error)
        }
    }
    
    
    func experienceDelete(_ urlString: String,params:[String: Any]? = nil, headers: [String: String], completion callback:@escaping CompletionCallBack){
        self.deleteRequest(stringApi: urlString,parameters: params, headers: headers) { (response, error) in
            callback(response, error)
        }
    }
    
    
    func deleteMediaFilesInExp(stringAPI: String, params: [String: Any]? = nil, headers: [String: String], completion callback:@escaping CompletionCallBack){
        self.postcall(urlString: stringAPI, inputParams: params,headers:headers) { (response, error) in
            callback(response, error)
        }
    }
    
    // MARK:- Reg FCM
    func regFcmPostcall(urlString:String, inputParams:[String:Any]? = nil, headers: [String: String]? = nil, isProgress: Bool = true, isResponseString:Bool = false, isJsonCoding:Bool = true, callback:@escaping CompletionCallBack) {
        //DLog(message: "API:=> \(urlString)?\(jsonFormatterDict (inputData:inputParams ?? [:]))")
        print("API:=> \(urlString)?\(jsonFormatterDict (inputData:inputParams ?? [:]))")
        UIApplication.shared.keyWindow?.endEditing(true)
        if !hasInternet() {
            showInternetAlertView()
            return
        }
        //        if isProgress{
        //            self.showProgress()
        //        }
        let enCoding:ParameterEncoding = isJsonCoding ? JSONEncoding.default : URLEncoding.default
        
        if(!isResponseString){
            Alamofire.request(urlString, method: .post, parameters: inputParams, encoding: enCoding, headers: headers).responseJSON { (responseFeed:DataResponse<Any>) in
                //  self.dismissProgress()
                do {
                    let apiResponse:Any = try JSONSerialization.jsonObject(with: responseFeed.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    print("response: \(apiResponse)")
                    callback(apiResponse, responseFeed.error)
                }
                catch {
                    print(error.localizedDescription)
                    callback([:], error)
                }
            }
        }
        else{
            Alamofire.request(urlString, method: .post, parameters: inputParams, encoding: enCoding, headers: headers).responseString { (responseFeed:DataResponse<String>) in
                //  self.dismissProgress()
                if responseFeed.result.isSuccess && responseFeed.response?.statusCode == 200 {
                    callback(responseFeed.result.value, responseFeed.error)
                }
                print(responseFeed)
                
            }
        }
        
    }
    
    //MARK:- Post Request
    func postcall(urlString:String, inputParams:[String:Any]? = nil, headers: [String: String]? = nil, isProgress: Bool = true, isResponseString:Bool = false, isJsonCoding:Bool = true, callback:@escaping CompletionCallBack) {
        //DLog(message: "API:=> \(urlString)?\(jsonFormatterDict (inputData:inputParams ?? [:]))")
        print("API:=> \(urlString)?\(jsonFormatterDict (inputData:inputParams ?? [:]))")
        UIApplication.shared.keyWindow?.endEditing(true)
        if !hasInternet() {
            showInternetAlertView()
            return
        }
        if isProgress{
            self.showProgress()
        }
        let enCoding:ParameterEncoding = isJsonCoding ? JSONEncoding.default : URLEncoding.default
        
        if(!isResponseString){
            Alamofire.request(urlString, method: .post, parameters: inputParams, encoding: enCoding, headers: headers).responseJSON { (responseFeed:DataResponse<Any>) in
                self.dismissProgress()
                do {
                    let apiResponse:Any = try JSONSerialization.jsonObject(with: responseFeed.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    print("response: \(apiResponse)")
                    callback(apiResponse, responseFeed.error)
                }
                catch {
                    print(error.localizedDescription)
                    callback([:], error)
                }
            }
        }
        else{
            Alamofire.request(urlString, method: .post, parameters: inputParams, encoding: enCoding, headers: headers).responseString { (responseFeed:DataResponse<String>) in
                self.dismissProgress()
                if responseFeed.result.isSuccess && responseFeed.response?.statusCode == 200 {
                    callback(responseFeed.result.value, responseFeed.error)
                }
                print(responseFeed)
                
            }
        }
        
    }
    
    //MARK:- GET TAGS
    
    func getTags(stringApi: String,parameters: [String: Any]? = nil, headers: [String: String], isProgress: Bool = true, callback: @escaping CompletionCallBack){
        if(hasInternet()){
            
            print("API:=> \(stringApi)?\(jsonFormatterDict (inputData:parameters ?? [:]))?\(jsonFormatterDict (inputData:headers ?? [:] ))")
            Alamofire.request(stringApi, method: .get, parameters: parameters, headers: headers).responseJSON{ (response) in
                do{
                    let apiResponse: Any = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)
                    print("response: \(apiResponse)")
                    callback(apiResponse as AnyObject?, response.error)
                   
                }
                catch{
                    callback([:] as AnyObject, response.error)
                    
                }
            }
        }
        else{
            showInternetAlertView()
        }
    }
    
    
    //MARK:- Get Request
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
    //MARK:- Put Request
    func putRequest(stringApi: String,parameters: [String: Any]? = nil, headers: [String: String],callback: @escaping CompletionCallBack){
        if(hasInternet()){
            self.showProgress()
            Alamofire.request(stringApi, method: .put, parameters: parameters,  encoding: JSONEncoding.default, headers: headers).responseJSON{ (response) in
                self.dismissProgress()
                do{
                    let apiResponse: Any = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)
                    print("response: \(apiResponse)")
                    callback(apiResponse as AnyObject?, response.error)
                }
                catch{
                    callback([:] as AnyObject, response.error)
                }
            }
        }
        else{
            showInternetAlertView()
        }
    }
    
}
extension APIManager {
    // MARK:- POST File Upload
    
    func postFile(stringApi: String, parameters: [String: Any]? = [:], uploads : [DataUpload],headers: [String: String], callback: @escaping CompletionCallBack) {
        print("postRequest :",stringApi)
        print(parameters!)
        print(headers)
        print(uploads)
        if(hasInternet()){
            
            let URL = try! URLRequest(url: stringApi, method: .post,headers: headers)
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                for upload in uploads {
                    if upload.fileName != nil {
                        multipartFormData.append(upload.datavalue, withName: "doc", fileName: upload.fileName, mimeType: upload.mime)
                    }
                }
                
                for (key, value) in parameters! {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                    
                }
            }, with: URL, encodingCompletion: { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (Progress) in
                        SVProgressHUD.showProgress(Float(Progress.fractionCompleted))
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        
                            print(response.request!)
                                              print(response.response!)
                                           // original URL request
                                              // URL response
                                               print(response.data!)     // server data
                                               print(response.result)
                       // result of response serialization
                        //                        self.showSuccesAlert()
                        SVProgressHUD.dismiss()
                        do {
                            
                            let apiResponse = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                            print(apiResponse)
                            callback(apiResponse as AnyObject?, response.error)
                        }
                        catch {
                            callback([:] as AnyObject, response.error)
                        }
                    }
                    
                case .failure(let encodingError):
                    SVProgressHUD.dismiss()
                    callback([:] as AnyObject, encodingError)
                    print(encodingError)
                }
                
            })
        }
        else{
            SVProgressHUD.dismiss()
            showInternetAlertView()
        }
        
    }
    func postFileRequestwithHeader(stringApi: String, parameters: [String: AnyObject]? = [:], uploads : [FileUpload],headers: [String: String], callback: @escaping CompletionCallBack) {
        print("postRequest :",stringApi)
        print(parameters!)
        print(headers)
        if(hasInternet()){
            
            let URL = try! URLRequest(url: stringApi, method: .post,headers: headers)
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                for upload in uploads {
                    if upload.imgFile != nil {
                        multipartFormData.append(upload.imgFile.jpegData(compressionQuality: 0.1)!, withName: "image", fileName: upload.fileName, mimeType: "image/jpeg")
                    }
                }
                
                for (key, value) in parameters! {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                    
                }
            }, with: URL, encodingCompletion: { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (Progress) in
                        SVProgressHUD.showProgress(Float(Progress.fractionCompleted))
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        print(response.request!)  // original URL request
                        //  print(response.response!) // URL response
                        print(response.data!)     // server data
                        print(response.result)    // result of response serialization
                        //                        self.showSuccesAlert()
                        SVProgressHUD.dismiss()
                        do {
                            
                            let apiResponse = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                            print(apiResponse)
                            callback(apiResponse as AnyObject?, response.error)
                        }
                        catch {
                            callback([:] as AnyObject, response.error)
                        }
                    }
                    
                case .failure(let encodingError):
                    SVProgressHUD.dismiss()
                    callback([:] as AnyObject, encodingError)
                    print(encodingError)
                }
                
            })
        }
        else{
            SVProgressHUD.dismiss()
            showInternetAlertView()
        }
        
    }
    
    
    func postVoiceRequestwithHeader(stringApi: String, parameters: [String: AnyObject]? = [:], uploads : [VoiceUpload],headers: [String: String], callback: @escaping CompletionCallBack) {
        print("postRequest :",stringApi)
        print(parameters)
        print(headers)
        if(hasInternet()){
            
            let URL = try! URLRequest(url: stringApi, method: .post,headers: headers)
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                for upload in uploads {
                    if let url = upload.audio {
                        multipartFormData.append(url, withName: "file")
                    }
                }
                
                for (key, value) in parameters! {
                 
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                    
                }
            }, with: URL, encodingCompletion: { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (Progress) in
                        SVProgressHUD.showProgress(Float(Progress.fractionCompleted))
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        print(response.request!)  // original URL request
                        print(response.response!) // URL response
                        print(response.data!)     // server data
                        print(response.result)    // result of response serialization
                        //                        self.showSuccesAlert()
                        SVProgressHUD.dismiss()
                        do {
                            
                            let apiResponse = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                            print(apiResponse)
                            callback(apiResponse as AnyObject?, response.error)
                        }
                        catch {
                            callback([:] as AnyObject, response.error)
                        }
                    }
                    
                case .failure(let encodingError):
                    SVProgressHUD.dismiss()
                    callback([:] as AnyObject, encodingError)
                    print(encodingError)
                }
                
            })
        }
        else{
            SVProgressHUD.dismiss()
            showInternetAlertView()
        }
        
        
    }
    func postMediaFileRequest(stringApi: String, parameters: [String: AnyObject]? = [:], uploads : [FileUpload],headers: [String: String], callback: @escaping CompletionCallBack) {
        print("postRequest :",stringApi)
        print(parameters!)
        print(headers)
        if(hasInternet()){
            
            let URL = try! URLRequest(url: stringApi, method: .post,headers: headers)
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                for upload in uploads {
                    if upload.imgFile != nil {
                        multipartFormData.append(upload.imgFile.jpegData(compressionQuality: 0.1)!, withName: "media", fileName: upload.fileName, mimeType: "image/jpeg")
                    }
                }
                
                for (key, value) in parameters! {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                    
                }
            }, with: URL, encodingCompletion: { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (Progress) in
                        SVProgressHUD.showProgress(Float(Progress.fractionCompleted))
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        print(response.request!)  // original URL request
                        print(response.response!) // URL response
                        print(response.data!)     // server data
                        print(response.result)    // result of response serialization
                        //                        self.showSuccesAlert()
                        SVProgressHUD.dismiss()
                        do {
                            
                            let apiResponse = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                            print(apiResponse)
                            callback(apiResponse as AnyObject?, response.error)
                        }
                        catch {
                            callback([:] as AnyObject, response.error)
                        }
                    }
                    
                case .failure(let encodingError):
                    SVProgressHUD.dismiss()
                    callback([:] as AnyObject, encodingError)
                    print(encodingError)
                }
                
            })
        }
        else{
            SVProgressHUD.dismiss()
            showInternetAlertView()
        }
        
    }
    
    //MARK:- Delete Request
    func deleteRequest(stringApi: String,parameters: [String: Any]? = nil, headers: [String: String],callback: @escaping CompletionCallBack){
        if(hasInternet()){
            print("API:=> \(stringApi)?\(jsonFormatterDict (inputData:parameters ?? [:]))?\(jsonFormatterDict (inputData:headers ))")
            self.showProgress()
            Alamofire.request(stringApi, method: .delete, parameters: parameters, headers: headers).responseJSON{ (response) in
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

    class FileUpload {
        var fileName: String!
        var imgFile: UIImage!
        
        init(filename: String,image:UIImage = UIImage()){
            self.fileName = filename
            self.imgFile = image
        }
    }
class VoiceUpload {
    var fileName: String!
    var audio: URL!
    
    init(filename: String,audio: URL? = nil){
        self.fileName = filename
        self.audio = audio
    }
}

class DataUpload{
    var fileName: String!
    var mime: String
    var datavalue: Data!
    
    init(filename: String, mimeType: String,data: Data? = nil){
        self.fileName = filename
        self.datavalue = data
        self.mime = mimeType
    }
}


