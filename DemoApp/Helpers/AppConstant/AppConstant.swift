//
//  AppConstant.swift
//  DemoApp
//
//  Created by Arif on 13/12/19.
//  Copyright © 2019 GSM Plus Infotech. All rights reserved.
//

import Foundation
import UIKit

let USERDEFAULTS = UserDefaults.standard
let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

let STORYBOARDMAIN = UIStoryboard(name: "Main", bundle: nil)


struct BaseAPI {
    static let URL = "http://192.168.168.65:3000/api"
}

struct LoginAPI {
    static let loginURL = BaseAPI.URL + "/login"
}

struct SignUpAPI {
    static let signUpURL = BaseAPI.URL + "/signIN"
}

struct HomeAPI {
    static let homeURL = BaseAPI.URL + "/homePage"
}
