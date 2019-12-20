//
//  ViewControllerExtension.swift
//  MyProof
//
//  Created by Athi S on 01/07/19.
//  Copyright © 2019 gsmplus. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MobileCoreServices
import Photos
import Contacts




extension UIViewController{
   
  
    
    
    func addLefttitle(title: String){
        let lbltitle = UILabel()
        lbltitle.text = title
        lbltitle.font = UIFont.systemFont(ofSize: 15.0)
        lbltitle.textColor = UIColor.black
        let item = UIBarButtonItem(customView: lbltitle)
        var items = [UIBarButtonItem]()
        if var leftitems = self.navigationItem.leftBarButtonItems {
            leftitems.append(item)
            items = leftitems
        }
        else{
            items.append(item)
        }
        self.navigationItem.leftBarButtonItems = items
    }
    
    func isModal() -> Bool {
        if self.presentingViewController != nil {
            return true
        } else if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        } else if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
    
    func addBackButtonWithTitle(title: String) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFontSize, NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    
    var fixedSpace: UIBarButtonItem {
        let space: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        space.width = 5.0
        return space
    }
    
    
    var search: UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "search_icon"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(searchAction(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.contentHorizontalAlignment = .right
        return UIBarButtonItem(customView: button)
    }
    
    var attach: UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "new incident_disabled"), for: .normal)
        button.contentMode = .center
        button.addTarget(self, action: #selector(attachAction(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.contentHorizontalAlignment = .right
        return UIBarButtonItem(customView: button)
    }
    
    var files: UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icons8-folder-48"), for: .normal)
        button.contentMode = .center
        //button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(attachAction(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.contentHorizontalAlignment = .right
        return UIBarButtonItem(customView: button)
    }
    
    
    var filter: UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ic_filter"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(filterAction(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.contentHorizontalAlignment = .right
        return UIBarButtonItem(customView: button)
    }
    
    func addRightItem(_ isSearch: Bool = false){
        self.navigationItem.rightBarButtonItems = isSearch ? [fixedSpace, search] : [fixedSpace]
    }
    
    
    
    func addMutlipleRightItem(){
        self.navigationItem.rightBarButtonItems = [fixedSpace,  search]
    }
    
    func addFilterAndSearch(){
        self.navigationItem.rightBarButtonItems = [fixedSpace, filter, search]
    }
    
    func addSearch(){
        self.navigationItem.rightBarButtonItems = [fixedSpace, search]
    }
    
    func addFilter(){
        self.navigationItem.rightBarButtonItems = [filter]
    }
    func addAttachRightItem(){
        self.navigationItem.rightBarButtonItems = [fixedSpace, attach]
    }
    
    func addFileLeftItem(){
        self.navigationItem.leftBarButtonItems = [fixedSpace, files]
    }
    
    func addTasksFilter(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_filter").backSpace(), style: .plain, target: self, action: #selector(rightButtonAction(_:)))
    }
    
    func addRightButtonWithTitle(_ title: String){
        //        let button = UIButton(type: .system)
        //        button.setTitle(title, for: .normal)
        //        button.setTitleColor(UIColor.appTextBlue, for: .normal)
        //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        //        button.addTarget(self, action: #selector(rightButtonAction(_:)), for: .touchUpInside)
        //        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        let button = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(rightButtonAction(_:)))
        button.tintColor = UIColor.appTextBlue
        self.navigationItem.rightBarButtonItem = button
    }
    
    @objc func rightButtonAction(_ sender: UIBarButtonItem){
        print("Right button clicked")
    }
    
    func addLeftButtonWithTitle(_ title: String){
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(leftButtonAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func leftButtonAction(_ sender: UIButton){
        print("Right button clicked")
    }
    
    
    @objc func searchAction(_ sender: UIBarButtonItem){
        print("Search Action")
    }
    
    @objc func attachAction(_ sender: UIBarButtonItem){
        print("Attach Action")
    }
    
    @objc func filterAction(_ sender: UIBarButtonItem){
        print("Filter Action")
    }
    
    
    func navBarShadow(){
        //        let navBar = self.navigationController?.navigationBar
        //        navBar?.layer.shadowColor = UIColor.appShadow.cgColor
        //        navBar?.layer.shadowOpacity = 0.4
        //        navBar?.layer.shadowOffset = CGSize.zero
        //        navBar?.layer.shadowRadius = 5
        //        navBar?.layer.shadowPath = UIBezierPath(roundedRect: (navBar?.layer.bounds)!, cornerRadius: (navBar?.layer.cornerRadius)!).cgPath
    }
    func transform(){
        if UIDevice.current.deviceType == .iPhone5 {
            self.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    func checkLocationStaus(){
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                break
            case .notDetermined, .restricted, .denied:
                permissionAlert(title: "Please Turn on your geo loaction")
            }
        }else{
            LocationAlert()
        }
    }
    
    func addTitleView(title: String){
        let lbltitle = UILabel()
        let attributedString = NSMutableAttributedString(string: title)
        //attributedString.addAttribute(NSKernAttributeName, value: CGFloat(0.75), range: NSRange(location: 0, length: attributedString.length))
        lbltitle.attributedText = attributedString
        lbltitle.textColor = UIColor.white
        lbltitle.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.navigationItem.titleView = lbltitle
    }
    func getEmailTimes(date: Date) -> String {
           
           let formatter = DateFormatter()
           // initially set the format based on your datepicker date / server String
           formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
           
           let myString = formatter.string(from: date) // string purpose I add here
           // convert your string to date
           let yourDate = formatter.date(from: myString)
           //then again set the date format whhich type of output you need
           formatter.dateFormat = "MMM-dd  hh:mm a"
           // again convert your date to string
           let myStringafd = formatter.string(from: yourDate!)
           
           return myStringafd
           
       }
}


extension UIViewController{
    func showActionSheet(title: String?, message: String?, actionTitles:[String?], style: UIAlertController.Style = .alert, actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLibrary(){
            switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagepicker.sourceType = .photoLibrary
        imagepicker.allowsEditing = true
        self.present(imagepicker, animated: true, completion: nil)
             case .denied, .notDetermined, .restricted:
                    permissionAlert(title: "would like to access your library")
               }
    }
    
    func showCamera(_ device: UIImagePickerController.CameraDevice = .rear){
        //        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo){
        //        case .authorized:
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraDevice = device
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        //            break
        //        case .denied, .restricted,.notDetermined:
        //            self.permissionAlert(title: "would like to access your Camera.")
        //            break
        //
        //        }
    }
    
    func accessRequesttocamera(){
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authorizationStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video,completionHandler: { (granted:Bool) -> Void in
                if (granted == false) {
                    print(granted)
                }
                else {
                    print(granted)
                }
            })
        case .authorized:
            break
        case .denied, .restricted:
            break
        }
    }
    
    func accessRequestToLibrary(){
        PHPhotoLibrary.requestAuthorization({(status:PHAuthorizationStatus)in
            switch status{
            case .denied:
                print("access denied")
                break
            case .authorized:
                print("access granted")
                break
            default:
                break
            }
        })
    }
}


extension UIViewController{
    var backButton: UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return UIBarButtonItem(customView: button)
    }
    
    func addBackBarButton(){
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}


