//
//  App Constants.swift
//  MyProof
//
//  Created by Athi S on 01/07/19.
//  Copyright © 2019 gsmplus. All rights reserved.
//

import Foundation
import UIKit


let USERDEFAULTS = UserDefaults.standard
let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

let STORYBOARDMAIN = UIStoryboard(name: "Main", bundle: nil)


struct BaseAPI {
    static let URL = ""
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


struct DetailExperienceAPI {
    var getDetailExperienceURL = ""
    init(_ id: String){
        getDetailExperienceURL = BaseAPI.URL + "user/inner_page/experience_details/\(id)"
    }
    
}

struct AttachMediaExperienceAPI {
    var getAttachExperienceURL = ""
    var getMessageAndCallLogsURL = ""
    init(pgNo: String, month: String, year: String) {
       getAttachExperienceURL  = BaseAPI.URL + "user/draft/attach_list?page_no=" + pgNo + "&year=" + year + "&month=" + month
    }
    init(pgNo:String,type:String,expId: String) {
        getMessageAndCallLogsURL = BaseAPI.URL + "backup?type=\(type)&page_no=\(pgNo)&experience_id=\(expId)"
    }
    init(pgNo:String,type:String) {
        getMessageAndCallLogsURL = BaseAPI.URL + "backup?type=\(type)&page_no=\(pgNo)"
    }
}
