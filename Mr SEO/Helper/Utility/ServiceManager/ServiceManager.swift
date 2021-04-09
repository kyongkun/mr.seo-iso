//
//  ServiceManager.swift
//  KYT
//
//  Created by Kavin Soni on 14/11/19.
//  Copyright © 2019 Kavin Soni. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration


typealias ApiCallSuccessBlock = (Bool,NSDictionary) -> Void
typealias ApiCallFailureBlock = (Bool,NSError?,NSDictionary?) -> Void
typealias APIResponseBlock = ((_ response: NSDictionary?,_ isSuccess: Bool,_ error: String?)->())
typealias APIResponseStringBlock = ((_ response: String?,_ isSuccess: Bool,_ error: String?)->())

typealias APIResponseBlockImage = ((_ param:[String:Any], _ imgURL:String, _ isSuccess: Bool,_ error: String?)->())


class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
enum APITYPE {
    //User
    case Login
    case GetBankName
    case Register
    case VerifyOTP
    case Forgot
    case GetHomeData
    case UpdateProfile
    case MyContent
    case GetPlatform
    case Support
    case UpdateNotification
    case CreatePost
    case PostStatus
    case TandC
    case Logout
    case ChangePassword
    case GetCategory
    case MyCompletedPoints
    case GetCoinHistory
    case GetThereadList
    case CheckAdminButton
    case GetPostDetails
    case GetMyPostDetails
    case ChatHistory
    case SendMessage
    case AppliedForHelp
    case EditPost
    case ChangeStatus
    case HelpPostDetails
    case UploadImage
    case GetNotice
    case AdminChatHIstory
    case SendMsgToAdmin
    case AutoMessage
    
    //New API
    case GetHome
    
    func getEndPoint() -> String {
        
        switch self {
        case .AutoMessage:
            return "V1/chat/admin_auto_message"
        case .CheckAdminButton:
            return "V1/chat/admin_chat_option"
        case .Login:
            return "V1/login"
        case .Register:
            return "V1/signup"
        case .GetBankName:
            return "V1/bankList"
        case .VerifyOTP:
            return "V1/verify_otp"
        case .Forgot:
            return "V1/forgot_password"
        case .GetHomeData:
            return "V1/post/getPosts"
        case .UpdateProfile:
            return "V1/user/updateProfile"
        case .MyContent:
            return "V1/post/myPostList"
        case .GetPlatform:
            return "V1/post/getPlatform"
        case .Support:
            return "V1/user/createSupport"
        case .UpdateNotification:
            return "V1/user/updateNotificationStatus"
        case .CreatePost:
            return "V1/post/createPosts"
        case .PostStatus:
            return "V1/post/updatePostStatus"
        case .TandC:
            return "V1/content/term_condition"
        case .Logout:
            return "V1/user/logout"
        case .ChangePassword:
            return "V1/user/change_password"
        case .GetCategory:
            return "V1/post/getCategory"
        case .MyCompletedPoints:
            return "V1/post/myCompletedPostList"
        case .GetCoinHistory:
            return "V1/user/coin_history"
        case .GetThereadList:
            return "V1/chat/thread_list"
        case .GetPostDetails:
            return "V1/post/get_post_details"
        case .GetMyPostDetails:
            return "V1/post/my_post_details"
        case .ChatHistory:
            return "V1/chat/chat_history"
        case .SendMessage:
            return "V1/chat/chat"
        case .GetHome:
            return "V1/post/home"
        case .AppliedForHelp:
            return "V1/post/apply_for_help"
        case .EditPost:
            return "V1/post/editPosts"
        case .ChangeStatus:
            return "V1/post/help_status_change"
        case .HelpPostDetails:
            return "V1/post/help_post_details"
        case .UploadImage:
            return "V1/post/upload_document"
        case .GetNotice:
            return "V1/user/notice_list"
        case .AdminChatHIstory:
            return "V1/chat/admin_chat_history"
        case .SendMsgToAdmin:
            return "V1/chat/admin_chat"
        }
    }
}


class ServiceManager: NSObject{
    
    
    //MARK:- Singleton
    static let shared:ServiceManager = ServiceManager()
    
    // MARK: - Static Variable
    let baseURL = "http://hexeros.com/dev/mr-seo/public/api/"
    
    static var previousAPICallRequestParams:(APITYPE,[String:Any]?)?
    
    static var previousAPICallRequestMultiParams:(APITYPE,[[String:Any]]?)?
    
    func callAPI(WithType apiType:APITYPE, WithParams params:String, Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        
        if isInternetAvailable() == true {
            
        }else{
            let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            return
        }
        
        
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            
            print("------  Parameters --------")
            print(params)
            print("------  Parameters --------")
            
            
            let apiUrl:String = "\(self.baseURL)\(apiType.getEndPoint())/\(params)"
            
            print(apiUrl)
            SHOW_CUSTOM_LOADER()
            
            AF.request(apiUrl, method: .get, parameters:[:], encoding: URLEncoding.default, headers:[:]).responseJSON
                { (response) in
                    
                    switch response.result{
                        
                    case .success(let json):
                        
                        print(json)
                        let mainStatusCode:Int = (response.response?.statusCode)!
                        HIDE_CUSTOM_LOADER()
                        
                        if let jsonResponse = json as? NSDictionary
                        {
                            
                            successBlock(jsonResponse, true, nil)
                            
                            
                        }else{
                            print("Json Object is not NSDictionary : Please Check this API \(apiType.getEndPoint())")
                            successBlock(nil, true, nil)
                        }
                        
                        break
                    case .failure(let _):
                        // You Got Failure :(
                        HIDE_CUSTOM_LOADER()
                        
                        print("Response Status Code :: \(response.response?.statusCode ?? 400)")
                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
                        print(datastring ?? "Test")
                        failureBlock(nil,false,"")
                        break
                    }
            }
        }else{
            let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            //            (alertController, animated: true, completion: nil)
        }
    }
    
    
    func getLatLongFromAddress(address:String, Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void {
        let apiUrl = ""
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            
            
            var headers: HTTPHeaders = [:]
            
            headers = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            
            print(apiUrl)
            SHOW_CUSTOM_LOADER()
          
            
            AF.request(apiUrl, method: .post, parameters: ["address":address],encoding:
                URLEncoding.default, headers: headers).responseJSON
                { (response) in
                    
                    switch response.result {
                    case .success(let json):
                        HIDE_CUSTOM_LOADER()
                        print(json)
                        
                        if let jsonResponse = json as? NSDictionary
                        {
                            successBlock(jsonResponse, true, nil)
                        }
                        
                    case .failure( _):
                        HIDE_CUSTOM_LOADER()
                        let alertController = UIAlertController(title: Constant.APP_NAME, message: "Something went wrong", preferredStyle: .alert)
                        HIDE_CUSTOM_LOADER()
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        successBlock(nil, false, nil)
                        
                        let keyWindow: UIWindow? = UIApplication.shared.keyWindow
                        keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                        failureBlock(nil,false,"Something went wrong.")
                    }
            }
            
        }
        else{
            let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
            HIDE_CUSTOM_LOADER()
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            //            (alertController, animated: true, completion: nil)
        }
    }
    func callAPIPostWithOutLoader(WithType apiType:APITYPE,isAuth:Bool, WithParams params:[String:Any], Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
        {
            HIDE_CUSTOM_LOADER()
            if Connectivity.isConnectedToInternet() {
                print("Yes! internet is available.")
                // do some tasks..
                /* API URL */
                
                print("------  Parameters --------")
                print(params)
                print("------  Parameters --------")
                
                
                var headers: HTTPHeaders = [:]//
                
                
                    if isAuth == true{
                        let apitocken = EstalimUser.shared.token
                        headers = ["Accept":"application/json","Authorization": "Bearer " + apitocken]
                    }
                
                
                let apiUrl:String = "\(self.baseURL)\(apiType.getEndPoint())"
                print("headers :",headers)

                print("apiUrl :",apiUrl)
                
                //SHOW_CUSTOM_LOADER()
                
                
                AF.request(apiUrl, method: .post, parameters: params,encoding:
                    URLEncoding.default, headers: headers).responseJSON
                    { (response) in
                        
                        switch response.result {
                        case .success(let json):
                           // HIDE_CUSTOM_LOADER()
                            print(json)
                            if let jsonResponse = json as? NSDictionary
                            {
                                let dataResponce:Dictionary<String,Any> = jsonResponse as! Dictionary<String, Any>
                                let StatusCode = jsonResponse["status"] as? Int
                                if(StatusCode == 307)
                                {

                                }
                                else if(StatusCode == 401)
                                {
                                    
                                }
                                else if (StatusCode == 412){
                                    if let errorMessage:String = dataResponce["message"] as? String{
                                        if let topController = UIApplication.topViewController() {
                                        showAlertWithTitleFromVC(vc: topController, andMessage: errorMessage)
                                        }
                                    }
                                }
                                successBlock(jsonResponse, true, nil)
                            }
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                            print("\n\n===========Error===========")
                            print("Error Code: \(error._code)")
                            print("Error Messsage: \(error.localizedDescription)")
                            if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                                print("Server Error: " + str)
                            }
                            debugPrint(error as Any)
                            print("===========================\n\n")
                            //HIDE_CUSTOM_LOADER()
                            let alertController = UIAlertController(title: Constant.APP_NAME, message: "Something went wrong", preferredStyle: .alert)
                            
                            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(defaultAction)
                            successBlock(nil, false, nil)
                            
                            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
                            
                            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
                            // keyWindow.makeKeyAndVisible()
                            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                            failureBlock(nil,false,"Something went wrong.")
                        }
                }
                
            }
            else{
                let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
                HIDE_CUSTOM_LOADER()
                
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                
                let keyWindow: UIWindow? = UIApplication.shared.keyWindow
                
                // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
                // keyWindow.makeKeyAndVisible()
                keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                
                //            (alertController, animated: true, completion: nil)
            }
        }
    func callAPIPostWithJson(WithType apiType:APITYPE,isAuth:Bool, WithParams params:Parameters, Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        SHOW_CUSTOM_LOADER()
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            
            print("------  Parameters --------")
            print(params as Parameters)
            print("------  Parameters --------")
            
            
            var headers: HTTPHeaders = [:]//
            headers = ["Accept-Language":EstalimUser.shared.language,"Accept": "application/json",
                       "Content-Type": "application/json","Authorization":"Bearer " + EstalimUser.shared.token]
            
//                if isAuth == true{
//                    let apitocken = EstalimUser.shared.token
//
//                }
            
            
            let apiUrl:String = "\(self.baseURL)\(apiType.getEndPoint())"
            print("headers :",headers)

            print("apiUrl :",apiUrl)
            
            var request = URLRequest(url: URL(string:apiUrl)!)

            request.httpBody = try? JSONSerialization.data(withJSONObject: params)

            AF.request(apiUrl, method: .post, parameters: params,encoding:
                        JSONEncoding.default, headers: headers).responseJSON
                { (response) in
                 //   guard response.error == nil else {
                        // handle error (including validate error) here, e.g.
//                    if response.response?.statusCode == 400 {
//                            // handle 400 Bad Request
//                        if let message = response.response?.value(forKey: "message") as? String{
//
//                                if let topController = UIApplication.topViewController() {
//                                    showAlertWithTitleFromVC(vc: topController, andMessage: "nothing")
//                                }
//                            }
//                        }
//                        return
//                    }
                    
                    let statusCode = response.response?.statusCode
                    print("statusCode :",statusCode!)

                    switch response.result {
                    case .success(let json):
                        HIDE_CUSTOM_LOADER()
                        print(json)
                        
                        if let jsonResponse = json as? NSDictionary
                        {
                            let dataResponce:Dictionary<String,Any> = jsonResponse as! Dictionary<String, Any>
                            if(statusCode == 307)
                            {
                                if let errorMessage:String = dataResponce["message"] as? String{
                                    if let LIveURL:String = dataResponce["iOS_live_application_url"] as? String{
                                        if let topController = UIApplication.topViewController() {

                                        showAlertWithTitleFromVC(vc: topController, title: Constant.APP_NAME, andMessage: errorMessage, buttons: ["Open Store"]) { (i) in
                                            if let url = URL(string: LIveURL),
                                                UIApplication.shared.canOpenURL(url){
                                                guard let url = URL(string: "\(url)"), !url.absoluteString.isEmpty else {
                                                   return
                                                }
                                                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                            }
                                        }
                                        }
                                    }
                                }
                            }
                            else if(statusCode == 401)
                            {

                                failureBlock(nil,false,"Something went wrong.")

                                if let errorMessage:String =  dataResponce["message"] as? String{
                                    if let topController = UIApplication.topViewController() {
                                        showAlertWithTitleFromVC(vc: topController, title: Constant.APP_NAME , andMessage: errorMessage, buttons: ["확인"]) { (i) in
                                            
                                            if #available(iOS 13, *) {
                                                sceneDelegate.makeLoginAsRoot()
                                            }
                                            else{
                                                appDelegate.makeLoginAsRoot()
                                            }
                                            }
                                    }
                                }
                            }
                            else if (statusCode == 412){
                                if let errorMessage:String = dataResponce["message"] as? String{
                                    if let topController = UIApplication.topViewController() {
                                    showAlertWithTitleFromVC(vc: topController, andMessage: errorMessage)
                                    }
                                }
                            }
                            
                            else if (statusCode == 200){
                                successBlock(jsonResponse, true, nil)
                            }
                            else{
                                if let errorMessage:String = dataResponce["message"] as? String{
                                    if let topController = UIApplication.topViewController() {
                                    showAlertWithTitleFromVC(vc: topController, andMessage: errorMessage)
                                    }
                                }
                            }
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        print("\n\n===========Error===========")
                        print("Error Code: \(error._code)")
                        print("Error Messsage: \(error.localizedDescription)")
                        if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                            print("Server Error: " + str)
                        }
                        debugPrint(error as Any)
                        print("===========================\n\n")
                        HIDE_CUSTOM_LOADER()
                        let alertController = UIAlertController(title: Constant.APP_NAME, message: "Something went wrong", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        successBlock(nil, false, nil)
                        
                        let keyWindow: UIWindow? = UIApplication.shared.keyWindow
                        
                        // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
                        // keyWindow.makeKeyAndVisible()
                        keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                        failureBlock(nil,false,"Something went wrong.")
                    }
            }
            
        }
        else{
            let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
            HIDE_CUSTOM_LOADER()
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            //            (alertController, animated: true, completion: nil)
        }
    }
    func callAPIPost(WithType apiType:APITYPE,isAuth:Bool, WithParams params:Parameters, Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        SHOW_CUSTOM_LOADER()
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            
            print("------  Parameters --------")
            print(params as Parameters)
            print("------  Parameters --------")
            
            
            var headers: HTTPHeaders = [:]//
            

                if isAuth == true{
                    headers = ["Accept": "application/json",
                               "Authorization":"Bearer " + EstalimUser.shared.token]
                }
            
            
            let apiUrl:String = "\(self.baseURL)\(apiType.getEndPoint())"
            print("headers :",headers)

            print("apiUrl :",apiUrl)
            
            var request = URLRequest(url: URL(string:apiUrl)!)

            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
            
            AF.request(apiUrl, method: .post, parameters: params,encoding:
                                URLEncoding.default, headers: headers).responseJSON
                { (response) in
                    let statusCode = response.response?.statusCode
                    print("statusCode :",statusCode ?? 0)

                    switch response.result {
                    case .success(let json):
                        HIDE_CUSTOM_LOADER()
                        print(json)
                        
                        if let jsonResponse = json as? NSDictionary
                        {
                            let dataResponce:Dictionary<String,Any> = jsonResponse as! Dictionary<String, Any>
                            if(statusCode == 307)
                            {
                                failureBlock(nil,false,"Something went wrong.")

                                if let errorMessage:String = dataResponce["message"] as? String{
                                    if let LIveURL:String = dataResponce["iOS_live_application_url"] as? String{
                                        if let topController = UIApplication.topViewController() {

                                        showAlertWithTitleFromVC(vc: topController, title: Constant.APP_NAME, andMessage: errorMessage, buttons: ["Open Store"]) { (i) in
                                            if let url = URL(string: LIveURL),
                                                UIApplication.shared.canOpenURL(url){
                                                guard let url = URL(string: "\(url)"), !url.absoluteString.isEmpty else {
                                                   return
                                                }
                                                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                            }
                                        }
                                        }
                                    }
                                }
                            }
                            else if(statusCode == 401)
                            {

                                failureBlock(nil,false,"Something went wrong.")

                                if let errorMessage:String =  dataResponce["message"] as? String{
                                    if let topController = UIApplication.topViewController() {
                                        showAlertWithTitleFromVC(vc: topController, title: Constant.APP_NAME , andMessage: errorMessage, buttons: ["확인"]) { (i) in
                                            
                                            if #available(iOS 13, *) {
                                                sceneDelegate.makeLoginAsRoot()
                                            }
                                            else{
                                                appDelegate.makeLoginAsRoot()
                                            }
                                            }
                                    }
                                }
                            }
                            else if (statusCode == 412){
                                failureBlock(nil,false,"Something went wrong.")

                                if let errorMessage:String = dataResponce["message"] as? String{
                                    if let topController = UIApplication.topViewController() {
                                    showAlertWithTitleFromVC(vc: topController, andMessage: errorMessage)
                                    }
                                }
                            }
                            
                            else if (statusCode == 200){
                                if let errorMessage:String = dataResponce["message"] as? String{
                                successBlock(jsonResponse, true, errorMessage)
                                }
                                else{
                                    successBlock(jsonResponse, true, nil)
                                }
                            }
                            else{
                                failureBlock(nil,false,"Something went wrong.")
                                if let errorMessage:String = dataResponce["message"] as? String{
                                    if let topController = UIApplication.topViewController() {
                                    showAlertWithTitleFromVC(vc: topController, andMessage: errorMessage)
                                    }
                                }
                            }
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        print("\n\n===========Error===========")
                        print("Error Code: \(error._code)")
                        print("Error Messsage: \(error.localizedDescription)")
                        if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                            print("Server Error: " + str)
                        }
                        debugPrint(error as Any)
                        print("===========================\n\n")
                        HIDE_CUSTOM_LOADER()
                        let alertController = UIAlertController(title: Constant.APP_NAME, message: "Something went wrong", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        successBlock(nil, false, nil)
                        
                        let keyWindow: UIWindow? = UIApplication.shared.keyWindow
                        
                        // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
                        // keyWindow.makeKeyAndVisible()
                        keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                        failureBlock(nil,false,"Something went wrong.")
                    }
            }
            
        }
        else{
            let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
            HIDE_CUSTOM_LOADER()
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            //            (alertController, animated: true, completion: nil)
        }
    }
    
    
    
    ////********************************************
    
    
    func callGetAPIWithoutLoader(WithType apiType:APITYPE, WithParams params:String, Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            
            print("------  Parameters --------")
            print(params)
            print("------  Parameters --------")
            
            
            let apiUrl:String = "\(self.baseURL)\(apiType.getEndPoint())/\(params)"
            var headers: HTTPHeaders = [:]//
            headers = ["Accept-Language":EstalimUser.shared.language,"Accept": "application/json",
                       "Content-Type": "application/json","Authorization":"Bearer " + EstalimUser.shared.token]
         
            print(apiUrl)
            //SwiftLoader.show(animated: true)
            //            let apiUrl:String = "https://api.instagram.com/v1/users/self"///?access_token=Rgfe_rd=cr&ei=RFE9WdGhIfDy8Ae7pI2YBg&gws_rd=ssl
            AF.request(apiUrl, method: .get, parameters:[:], encoding: URLEncoding.default, headers:headers).responseJSON
                { (response) in
                    
                    switch response.result{
                        
                    case .success(let json):
                        
                        // You got Success :)
                        print(json)
                        //  print("Response Status Code :: \(response.response?.statusCode)")
                        //                        print(json as! NSDictionary)
                        
                        if let jsonResponse = json as? NSDictionary
                        {
                            
                            print(jsonResponse)
                            
                            if jsonResponse.value(forKey: "Status") as! String == "true"{
                                
                                //                                if ((jsonResponse.value(forKey: "data") as? NSDictionary) != nil){
                                
                                // let resultDict = jsonResponse.value(forKey: "data") as? NSDictionary
                                successBlock(jsonResponse, true, nil)
                                //                                }else{
                                //
                                //                                    successBlock(nil, true, nil)
                                //
                                //                                }
                            }else{
                                
                                if ((jsonResponse.value(forKey: "data") as? NSDictionary) != nil){
                                    let resultDict = jsonResponse.value(forKey: "data") as? NSDictionary
                                    
                                    successBlock(resultDict, false, nil)
                                }else{
                                    successBlock(nil, false, nil)
                                }
                                
                            }
                            
                        }else{
                            print("Json Object is not NSDictionary : Please Check this API \(apiType.getEndPoint())")
                            successBlock(nil, true, nil)
                        }
                        
                        break
                    case .failure(let error):
                        // You Got Failure :(
                        HIDE_CUSTOM_LOADER()
                        
                        print("Response Status Code :: \(response.response?.statusCode ?? 00 )")
                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
                        print(datastring ?? "Test")
                        failureBlock(nil,false,error as? String)
                        break
                    }
            }
        }else{
            let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            //            (alertController, animated: true, completion: nil)
        }
    }
    
    
    
    func callPutAPI(WithType apiType:APITYPE , passString:String , isHeader:Bool, WithParams params:[String:Any], Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            
            print("------  Parameters --------")
            print(params)
            print("------  Parameters --------")
            
            var headers: HTTPHeaders = [:]//
            if isHeader == true {
                headers = [
                    
                    "Content-Type": "application/x-www-form-urlencoded"//,"application/json",
                    //                    "Authorization": tokenPass
                ]
            }
            
            let apiUrl:String = "\(self.baseURL)\(apiType.getEndPoint())/\(passString)"
            SHOW_CUSTOM_LOADER()
            
            AF.request(apiUrl, method: .put, parameters:params, encoding: JSONEncoding.default, headers:headers).responseJSON
                { (response) in
                    
                    switch response.result{
                        
                    case .success(let json):
                        HIDE_CUSTOM_LOADER()
                        
                        print(json)
                        
                        if let jsonResponse = json as? NSDictionary
                        {
                            
                            if jsonResponse.value(forKey: "success") as! Bool == true  {
                                if let dict  = jsonResponse.value(forKey: "data") as? NSDictionary{
                                    successBlock(dict, true, nil)
                                }else{
                                    successBlock(jsonResponse, true, nil)
                                }
                                
                            }else{
                                
                                print("Json Object is not NSDictionary : Please Check this API \(apiType.getEndPoint())")
                                let msg = jsonResponse.value(forKey: "message") as? String
                                //                            successBlock(nil, false, msg )
                                failureBlock(nil,false,msg)
                                
                            }
                        }
                        
                        break
                    case .failure(let error):
                        // You Got Failure :(
                        HIDE_CUSTOM_LOADER()
                        
                        print("Response Status Code :: \(String(describing: response.response?.statusCode))")
                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
                        print(datastring ?? "Test")
                        failureBlock(nil,false,error as? String)
                        break
                    }
            }
        }else{
            let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            HIDE_CUSTOM_LOADER()
            
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func callGetHTMLAPI(WithType apiType:APITYPE , isAuth:Bool, passString:String, WithParams params:[String:Any], Success successBlock:@escaping APIResponseStringBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            var headers: HTTPHeaders = [:]//

            if isAuth == true{
                let apitocken = EstalimUser.shared.token
                print(apitocken)
               // headers = ["Accept-Language":EstalimUser.shared.language,"Accept": "application/json",
                 //          "Content-Type": "application/json","Authorization":"Bearer " + EstalimUser.shared.token]
                         }
            print("------  Parameters --------")
            print(params)
            print("------  Headers --------")
            print(headers)
          
            
         
            
            let apiUrl:String = "\(self.baseURL)\(apiType.getEndPoint())\(passString)"
            
            print(apiUrl)
            //SwiftLoader.show(animated: true)
            SHOW_CUSTOM_LOADER()
            
            AF.request(apiUrl, method: .get, parameters:params, encoding: URLEncoding.default, headers:[:]).responseJSON
                { (response) in
                    
                    switch response.result{
                        
                    case .success(let json):
                        HIDE_CUSTOM_LOADER()
                        let status:Int = response.response!.statusCode
                        print("service statuscode \(String(status))")

                        if status == 401 {
                            EstalimUser.shared.clear()
                            
                        }
                        if let jsonResponse = json as? String
                        {
                            print(json)
                            successBlock(jsonResponse,true,nil)
                        }
                        break
                    case .failure(let error):
                        // You Got Failure :(
                        HIDE_CUSTOM_LOADER()

                        if (response.response != nil) {
                            let status:Int = response.response!.statusCode
                                                   print("service statuscode \(String(status))")

                                                   print("Response Status Code :: \(String(describing: response.response?.statusCode))")
                                                   let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
                                                   print(datastring ?? "Test")
                            if status == 200{
                                successBlock(datastring as String?,true,nil)

                            }
                            else{
                                failureBlock(nil,false,error as? String)
                            }

//
                        }else {
                            failureBlock(nil,false, "")

                        }
                       
                        break
                    }
            }
        }else{
            let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            HIDE_CUSTOM_LOADER()
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            //            (alertController, animated: true, completion: nil)
        }
    }
    func callGetAPI(WithType apiType:APITYPE , isAuth:Bool, passString:String, WithParams params:[String:Any], Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            
            var headers: HTTPHeaders = [:]//
            headers = ["Accept-Language":EstalimUser.shared.language,"Accept": "application/json",
                       "Content-Type": "application/json","Authorization":"Bearer " + EstalimUser.shared.token]
         
            print("------  Parameters --------")
            print(params)
            print("------  Headers --------")
            print(headers)
            let apiUrl:String = "\(self.baseURL)\(apiType.getEndPoint())\(passString)"
            
            print(apiUrl)
            //SwiftLoader.show(animated: true)
            SHOW_CUSTOM_LOADER()
            
            AF.request(apiUrl, method: .get, parameters:params, encoding: URLEncoding.default, headers:headers).responseJSON
                { (response) in

                let statusCode = response.response?.statusCode

                    switch response.result{
                        
                    case .success(let json):
                        HIDE_CUSTOM_LOADER()
                        print(json)
                        
                        if let jsonResponse = json as? NSDictionary
                        {
                            let dataResponce:Dictionary<String,Any> = jsonResponse as! Dictionary<String, Any>
                            if(statusCode == 307)
                            {
                                if let errorMessage:String = dataResponce["message"] as? String{
                                    if let LIveURL:String = dataResponce["iOS_live_application_url"] as? String{
                                        if let topController = UIApplication.topViewController() {

                                        showAlertWithTitleFromVC(vc: topController, title: Constant.APP_NAME, andMessage: errorMessage, buttons: ["Open Store"]) { (i) in
                                            if let url = URL(string: LIveURL),
                                                UIApplication.shared.canOpenURL(url){
                                                guard let url = URL(string: "\(url)"), !url.absoluteString.isEmpty else {
                                                   return
                                                }
                                                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                            }
                                        }
                                        }
                                    }
                                }
                            }
                            else if(statusCode == 401)
                            {

//                                failureBlock(nil,false,"Something went wrong.")

                                if let errorMessage:String =  dataResponce["message"] as? String{
                                    if let topController = UIApplication.topViewController() {
                                        showAlertWithTitleFromVC(vc: topController, title: Constant.APP_NAME , andMessage: errorMessage, buttons: ["확인"]) { (i) in
                                            
                                            if #available(iOS 13, *) {
                                                sceneDelegate.makeLoginAsRoot()
                                            }
                                            else{
                                                appDelegate.makeLoginAsRoot()
                                            }
                                            }
                                    }
                                }
                            }
                            else if (statusCode == 412){
                                if let errorMessage:String = dataResponce["message"] as? String{
                                    if let topController = UIApplication.topViewController() {
                                    showAlertWithTitleFromVC(vc: topController, andMessage: errorMessage)
                                    }
                                }
                            }
                            
                            else if (statusCode == 200){
                                successBlock(jsonResponse, true, nil)
                            }
                            else{
                                if let errorMessage:String = dataResponce["message"] as? String{
                                    if let topController = UIApplication.topViewController() {
                                    showAlertWithTitleFromVC(vc: topController, andMessage: errorMessage)
                                    }
                                }
                            }
                        }
                    case .failure(let error):
                        // You Got Failure :(
                        HIDE_CUSTOM_LOADER()
                        print(error.localizedDescription)
                        print("\n\n===========Error===========")
                        print("Error Code: \(error._code)")
                        print("Error Messsage: \(error.localizedDescription)")
                        if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                            print("Server Error: " + str)
                        }
                        debugPrint(error as Any)
                        print("===========================\n\n")
                        HIDE_CUSTOM_LOADER()
                        let alertController = UIAlertController(title: Constant.APP_NAME, message: "Something went wrong", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        successBlock(nil, false, nil)
                        
                        let keyWindow: UIWindow? = UIApplication.shared.keyWindow
                        
                        // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
                        // keyWindow.makeKeyAndVisible()
                        keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                        failureBlock(nil,false,"Something went wrong.")
                       
                        break
                    }
            }
        }else{
            let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            HIDE_CUSTOM_LOADER()
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            //            (alertController, animated: true, completion: nil)
        }
    }
    
    
    
    //MARK: check internet connection
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    
  
        
    
        func callAPIWithMultipleImageWithOutLoader(WithType apiType:APITYPE, imageUpload:[UIImage],WithParams params:[String:Any], Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
        {
            
            if Connectivity.isConnectedToInternet() {
                print("Yes! internet is available.")
                // do some tasks..
                /* API URL */
                
                print("------  Parameters --------")
                print(params)
                print("------  Parameters --------")
                
                
                let apiUrl:String = "\(self.baseURL)\(apiType.getEndPoint())"
                print(apiUrl)
                let urlRqt = URLRequest(url: URL(string: apiUrl)!)


                let apitocken = EstalimUser.shared.token
    //            let apitocken = UserDefaults.standard.string(forKey: kapiToken)
                print(apitocken)
                var headers: HTTPHeaders = [:]//

                headers = ["Accept-Language":EstalimUser.shared.language,"Accept": "application/json",
                           "Content-Type": "application/json","Authorization":"Bearer " + EstalimUser.shared.token]
             
                
                
                
                AF.upload(multipartFormData: { multiPart in
                       for (key, value) in params {
                           if let temp = value as? String {
                               multiPart.append(temp.data(using: .utf8)!, withName: key)
                           }
                           if let temp = value as? Int {
                               multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                           }
                           if let temp = value as? NSArray {
                               temp.forEach({ element in
                                   let keyObj = key + "[]"
                                   if let string = element as? String {
                                       multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                                   } else
                                       if let num = element as? Int {
                                           let value = "\(num)"
                                           multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                                   }
                               })
                           }
                       }
                    for img in imageUpload {
                        guard let imgData = img.jpegData(compressionQuality: 0.4) else { return }
                       multiPart.append(imgData, withName: "file", fileName: "file.png", mimeType: "image/png")
                    }
                }, with: urlRqt as URLRequestConvertible)
                       .uploadProgress(queue: .main, closure: { progress in
                           //Current upload progress of file
                           print("Upload Progress: \(progress.fractionCompleted)")
                       })
                       .responseJSON(completionHandler: { data in
                           //Do what ever you want to do with response
                       })
                
            }else{
                HIDE_CUSTOM_LOADER()
                
                let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                
                let keyWindow: UIWindow? = UIApplication.shared.keyWindow
                
                // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
                // keyWindow.makeKeyAndVisible()
                keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                // (alertController, animated: true, completion: nil)
            }
        }
    
    func callAPIWithImage(WithType apiType:APITYPE, imageUpload:UIImage,imageName:String,WithParams params:[String:Any], Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            print("------  Parameters --------")
            print(params)
            print("------  Parameters --------")
            
            
            let apiUrl:String = "\(self.baseURL)\(apiType.getEndPoint())"
            print(apiUrl)

            let urlRqt = URLRequest(url: URL(string: apiUrl)!)
            let apitocken = EstalimUser.shared.token

            var headers: HTTPHeaders = [:]//
            headers = ["Accept-Language":EstalimUser.shared.language,"Accept": "application/json",
                       "Content-Type": "multipart/form-data","Authorization":"Bearer " + EstalimUser.shared.token]
            print("headers : ",headers)
            SHOW_CUSTOM_LOADER()
            var urlRequest = URLRequest(url: URL(string: apiUrl)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
               urlRequest.httpMethod = "POST"
               urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.headers = headers



               //Set Your Parameter
//               let parameterDict = NSMutableDictionary()
//               parameterDict.setValue(self.name, forKey: "name")

               //Set Image Data
            let imgData = imageUpload.jpegData(compressionQuality: 0.5)!

              // Now Execute
               AF.upload(multipartFormData: { multiPart in
                   for (key, value) in params {
                       if let temp = value as? String {
                        multiPart.append(temp.data(using: .utf8)!, withName: key )
                       }
                       if let temp = value as? Int {
                        multiPart.append("\(temp)".data(using: .utf8)!, withName: key )
                       }
                       if let temp = value as? NSArray {
                           temp.forEach({ element in
                            let keyObj = key + "[]"
                            print("keyObj:",keyObj)
                               if let string = element as? String {
                                print("string:",string)
                                   multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                               } else
                                   if let num = element as? Int {
                                       let value = "\(num)"
                                    print("num:",num)

                                       multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                               }
                           })
                       }
                   }
                    
                   multiPart.append(imgData, withName:imageName, fileName: "\(imageName).png", mimeType: "image/png")
               }, with: urlRequest)
                   .uploadProgress(queue: .main, closure: { progress in
                       //Current upload progress of file
                       print("Upload Progress: \(progress.fractionCompleted)")
                   })
                   .responseJSON(completionHandler: { data in

                              switch data.result {

                              case .success(_):
                               do {
                                HIDE_CUSTOM_LOADER()

                               let dataResponce = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary
                                let statusCode = data.response?.statusCode
                                if(statusCode == 307)
                                {
                                    if let errorMessage:String = dataResponce["message"] as? String{
                                        if let LIveURL:String = dataResponce["iOS_live_application_url"] as? String{
                                            if let topController = UIApplication.topViewController() {

                                            showAlertWithTitleFromVC(vc: topController, title: Constant.APP_NAME, andMessage: errorMessage, buttons: ["Open Store"]) { (i) in
                                                if let url = URL(string: LIveURL),
                                                    UIApplication.shared.canOpenURL(url){
                                                    guard let url = URL(string: "\(url)"), !url.absoluteString.isEmpty else {
                                                       return
                                                    }
                                                     UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                }
                                            }
                                            }
                                        }
                                    }
                                }
                                else if(statusCode == 401)
                                {

                                   // failureBlock(nil,false,"Something went wrong.")

                                    if let errorMessage:String =  dataResponce["message"] as? String{
                                        if let topController = UIApplication.topViewController() {
                                            showAlertWithTitleFromVC(vc: topController, title: Constant.APP_NAME , andMessage: errorMessage, buttons: ["확인"]) { (i) in
                                                
                                                if #available(iOS 13, *) {
                                                    sceneDelegate.makeLoginAsRoot()
                                                }
                                                else{
                                                    appDelegate.makeLoginAsRoot()
                                                }
                                                }
                                        }
                                    }
                                }
                                else if (statusCode == 412){
                                    if let errorMessage:String = dataResponce["message"] as? String{
                                        if let topController = UIApplication.topViewController() {
                                        showAlertWithTitleFromVC(vc: topController, andMessage: errorMessage)
                                        }
                                    }
                                }
                                
                                else if (statusCode == 200){
                                    successBlock(dataResponce, true, nil)
                                }
                                else{
                                    if let errorMessage:String = dataResponce["message"] as? String{
                                        if let topController = UIApplication.topViewController() {
                                        showAlertWithTitleFromVC(vc: topController, andMessage: errorMessage)
                                        }
                                    }
                                }
                                   print("Success!")
                                   print(dataResponce)
                              }
                              catch {
                                 // catch error.
                               print("catch error")

                                     }
                               break
                                   
                              case .failure(_):
                               print("failure")

                               break
                               
                           }


                   })
        }
        else{
            HIDE_CUSTOM_LOADER()
            
            let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    func callAPIWithMultipleImage(WithType apiType:APITYPE, imageUpload:[UIImage],WithParams params:[String:Any], Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        SHOW_CUSTOM_LOADER()
        let url:String = "\(self.baseURL)\(apiType.getEndPoint())"
        print(url)

        let apitocken = EstalimUser.shared.token
//            let apitocken = UserDefaults.standard.string(forKey: kapiToken)
        print(apitocken)
        var headers: HTTPHeaders = [:]//

        headers = ["Accept-Language":EstalimUser.shared.language,"Accept": "application/json",
                   "Content-Type": "multipart/form-data","Authorization":"Bearer " + EstalimUser.shared.token]
        if Connectivity.isConnectedToInternet() {
            AF.upload(multipartFormData: { (multipartFormData) in

                       for (key, value) in params {
                           multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                       }
                guard let imgData = imageUpload[0].jpegData(compressionQuality: 0.4) else { return }
                guard let imgData1 = imageUpload[1].jpegData(compressionQuality: 0.4) else { return }
                multipartFormData.append(imgData, withName: "profile_image", fileName: "profile_image.png", mimeType: "image/png")
                multipartFormData.append(imgData1, withName: "bank_image", fileName: "bank_image.png", mimeType: "image/png")
                
            }, to: url, usingThreshold: UInt64.init(), method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { data in
                //Do what ever you want to do with response
                print("Upload Complete: \(data)")
                switch data.result {
                

                case .success(_):
                 do {
                    HIDE_CUSTOM_LOADER()

                 let dataResponce = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary
                  let statusCode = data.response?.statusCode
                  if(statusCode == 307)
                  {
                      if let errorMessage:String = dataResponce["message"] as? String{
                          if let LIveURL:String = dataResponce["iOS_live_application_url"] as? String{
                              if let topController = UIApplication.topViewController() {

                              showAlertWithTitleFromVC(vc: topController, title: Constant.APP_NAME, andMessage: errorMessage, buttons: ["Open Store"]) { (i) in
                                  if let url = URL(string: LIveURL),
                                      UIApplication.shared.canOpenURL(url){
                                      guard let url = URL(string: "\(url)"), !url.absoluteString.isEmpty else {
                                         return
                                      }
                                       UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                  }
                              }
                              }
                          }
                      }
                  }
                  else if(statusCode == 401)
                  {

                      failureBlock(nil,false,"Something went wrong.")

                      if let errorMessage:String =  dataResponce["message"] as? String{
                          if let topController = UIApplication.topViewController() {
                              showAlertWithTitleFromVC(vc: topController, title: Constant.APP_NAME , andMessage: errorMessage, buttons: ["확인"]) { (i) in
                                  
                                  if #available(iOS 13, *) {
                                      sceneDelegate.makeLoginAsRoot()
                                  }
                                  else{
                                      appDelegate.makeLoginAsRoot()
                                  }
                                  }
                          }
                      }
                  }
                  else if (statusCode == 412){
                      if let errorMessage:String = dataResponce["message"] as? String{
                          if let topController = UIApplication.topViewController() {
                          showAlertWithTitleFromVC(vc: topController, andMessage: errorMessage)
                          }
                      }
                  }
                  
                  else if (statusCode == 200){
                      successBlock(dataResponce, true, nil)
                  }
                  else{
                      if let errorMessage:String = dataResponce["message"] as? String{
                          if let topController = UIApplication.topViewController() {
                          showAlertWithTitleFromVC(vc: topController, andMessage: errorMessage)
                          }
                      }
                  }
                     print("Success!")
                     print(dataResponce)
                }
                catch {
                   // catch error.
                 print("catch error")

                       }
                 break
                     
                case .failure(_):
                 print("failure")

                 break
                 
             }

            }).response { (data) in
                print(data)
            }
        }else{
            HIDE_CUSTOM_LOADER()
            
            let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    func callPutAPIWithMultipleImage(WithType apiType:APITYPE, imageUpload:UIImage,WithParams params:[String:Any], Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            
            print("------  Parameters --------")
            print(params)
            print("------  Parameters --------")
            
            
            let apiUrl:String = "\(self.baseURL)\(apiType.getEndPoint())"
            print(apiUrl)

            let apitocken = EstalimUser.shared.token
//            let apitocken = UserDefaults.standard.string(forKey: kapiToken)
            print(apitocken)
            var headers: HTTPHeaders = [:]//

            headers = ["Accept-Language":EstalimUser.shared.language,"Accept": "application/json",
                       "Content-Type": "multipart/form-data","Authorization":"Bearer " + EstalimUser.shared.token]
         SHOW_CUSTOM_LOADER()
            AF.upload(multipartFormData: { multiPart in
                   for (key, value) in params {
                       if let temp = value as? String {
                           multiPart.append(temp.data(using: .utf8)!, withName: key)
                       }
                       if let temp = value as? Int {
                           multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                       }
                       if let temp = value as? NSArray {
                           temp.forEach({ element in
                               let keyObj = key + "[]"
                               if let string = element as? String {
                                   multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                               } else
                                   if let num = element as? Int {
                                       let value = "\(num)"
                                       multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                               }
                           })
                       }
                   }
                 
                    guard let imgData = imageUpload.jpegData(compressionQuality: 0.4) else { return }
                   multiPart.append(imgData, withName: "file", fileName: "file.png", mimeType: "image/png")
                
            }, with: apiUrl as! URLRequestConvertible)
                   .uploadProgress(queue: .main, closure: { progress in
                       //Current upload progress of file
                       print("Upload Progress: \(progress.fractionCompleted)")
                   })
                   .responseJSON(completionHandler: { data in
                       //Do what ever you want to do with response
                    HIDE_CUSTOM_LOADER()
                   })
            
        }else{
            HIDE_CUSTOM_LOADER()
            
            let alertController = UIAlertController(title: Constant.APP_NAME, message: "Internet Connection seems to be offline", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            // (alertController, animated: true, completion: nil)
        }
    }
    
    
    
}

public func HIDE_CUSTOM_LOADER(){
    
        LoadingDailog.sharedInstance.stopLoader()
    
}
public func SHOW_CUSTOM_LOADER(){
        LoadingDailog.sharedInstance.startLoader()

}



