//
//  EstalimUser.swift
//  Estalim
//
//  Created by Mac on 21/12/20.
//  Copyright © 2020 ZestBrains PVT LTD. All rights reserved.
//

//
//  jamalekUser.swift
//  Jamalek
//
//  Created by Mac on 06/02/20.
//  Copyright © 2020 ZestBrains PVT LTD. All rights reserved.
//

import UIKit

class EstalimUser: NSObject  ,NSCoding {
    
    var language        = ""
    var updated_at      = ""
    var type            = ""
    var token           = ""
    var reset_token     = ""
    var profile_image   = ""
    var nick_name       = ""
    var name            = ""
    var mobile          = ""
    var is_active       = ""
    var info            = ""
    var id              = ""
    var email           = ""
    var deleted_at      = ""
    var created_at      = ""
    var country_code    = "+82"
    var bank_name       = ""
    var bank_image      = ""
    var account_number  = ""
    var is_notify       = ""
    var coin        = "0"
    var RememberMe      = ""
    var set_image = ""
    var RememberMeEmail      = ""
    var RememberMePassword      = ""
    
    
    var preference = [NSDictionary]()
    static var shared: EstalimUser = EstalimUser()
    override init()
    {
        super.init()
        let encodedObject:NSData? = UserDefaults.standard.object(forKey: "ELUser") as? NSData
        if encodedObject != nil
        {
            let userDefaultsReference = UserDefaults.standard
            let encodedeObject:NSData = userDefaultsReference.object(forKey: "ELUser") as! NSData
            let kUSerObject:EstalimUser = NSKeyedUnarchiver.unarchiveObject(with: encodedeObject as Data) as! EstalimUser
            self.loadContent(fromUser: kUSerObject);
        }
    }
    
    
    required init?(coder aDecoder: NSCoder)    {
        super.init()
        if let value = aDecoder.decodeObject(forKey: "RememberMeEmail") as? String{self.RememberMeEmail = value}
        if let value = aDecoder.decodeObject(forKey: "RememberMePassword") as? String{self.RememberMePassword = value}
        if let value = aDecoder.decodeObject(forKey: "set_image") as? String{self.set_image = value}

        if let value = aDecoder.decodeObject(forKey: "language") as? String{self.language = value}
        if let value = aDecoder.decodeObject(forKey: "updated_at") as? String{self.updated_at = value}
        if let value = aDecoder.decodeObject(forKey: "type") as? String{self.type = value}
        if let value = aDecoder.decodeObject(forKey: "token") as? String{self.token = value}
        if let value = aDecoder.decodeObject(forKey: "reset_token") as? String{self.reset_token = value}
        if let value = aDecoder.decodeObject(forKey: "profile_image") as? String{self.profile_image = value}
        if let value = aDecoder.decodeObject(forKey: "nick_name") as? String{self.nick_name = value}
        if let value = aDecoder.decodeObject(forKey: "name") as? String{self.name = value}
        if let value = aDecoder.decodeObject(forKey: "mobile") as? String{self.mobile = value}
        if let value = aDecoder.decodeObject(forKey: "is_active") as? String{self.is_active = value}
        if let value = aDecoder.decodeObject(forKey: "info") as? String{self.info = value}
        if let value = aDecoder.decodeObject(forKey: "id") as? String{self.id = value}
        if let value = aDecoder.decodeObject(forKey: "email") as? String{self.email = value}
        if let value = aDecoder.decodeObject(forKey: "deleted_at") as? String{self.deleted_at = value}
        if let value = aDecoder.decodeObject(forKey: "created_at") as? String{self.created_at = value}
        if let value = aDecoder.decodeObject(forKey: "country_code") as? String{self.country_code = value}
        if let value = aDecoder.decodeObject(forKey: "bank_name") as? String{self.bank_name = value}
        if let value = aDecoder.decodeObject(forKey: "bank_image") as? String{self.bank_image = value}
        if let value = aDecoder.decodeObject(forKey: "account_number") as? String{self.account_number = value}
        if let value = aDecoder.decodeObject(forKey: "is_notify") as? String{self.is_notify = value}
        if let value = aDecoder.decodeObject(forKey: "coin") as? String{self.coin = value}
        if let value = aDecoder.decodeObject(forKey: "RememberMe") as? String{self.RememberMe = value}
        
    }
    
    func loadUser() -> EstalimUser
    {
        let userDefaultsReference = UserDefaults.standard
        let encodedeObject:NSData = userDefaultsReference.object(forKey: "ELUser") as! NSData
        let kUSerObject:EstalimUser = NSKeyedUnarchiver.unarchiveObject(with: encodedeObject as Data) as! EstalimUser
        return kUSerObject
    }
    
    
    func encode(with aCoder: NSCoder)    {
        aCoder.encode(self.RememberMeEmail ,forKey: "RememberMeEmail")
        aCoder.encode(self.RememberMePassword ,forKey: "RememberMePassword")
        
        aCoder.encode(self.set_image ,forKey: "set_image")
        aCoder.encode(self.language ,forKey: "language")
        aCoder.encode(self.updated_at ,forKey: "updated_at")
        aCoder.encode(self.type ,forKey: "type")
        aCoder.encode(self.token ,forKey: "token")
        aCoder.encode(self.reset_token ,forKey: "reset_token")
        aCoder.encode(self.profile_image ,forKey: "profile_image")
        aCoder.encode(self.nick_name ,forKey: "nick_name")
        aCoder.encode(self.name ,forKey: "name")
        aCoder.encode(self.mobile ,forKey: "mobile")
        aCoder.encode(self.is_active ,forKey: "is_active")
        aCoder.encode(self.info ,forKey: "info")
        aCoder.encode(self.id ,forKey: "id")
        aCoder.encode(self.email ,forKey: "email")
        aCoder.encode(self.deleted_at ,forKey: "deleted_at")
        aCoder.encode(self.created_at ,forKey: "created_at")
        aCoder.encode(self.country_code ,forKey: "country_code")
        aCoder.encode(self.bank_name ,forKey: "bank_name")
        aCoder.encode(self.bank_image ,forKey: "bank_image")
        aCoder.encode(self.account_number ,forKey: "account_number")
        aCoder.encode(self.is_notify ,forKey: "is_notify")
        aCoder.encode(self.coin ,forKey: "coin")
        aCoder.encode(self.RememberMe ,forKey: "RememberMe")
        

    }
    
    private func loadContent(fromUser user:EstalimUser) -> Void    {
        self.RememberMeEmail = user.RememberMeEmail
        self.RememberMePassword = user.RememberMePassword
        self.language = user.language
        self.updated_at = user.updated_at
        self.type = user.type
        self.token = user.token
        self.reset_token = user.reset_token
        self.profile_image = user.profile_image
        self.nick_name = user.nick_name
        self.name = user.name
        self.mobile = user.mobile
        self.is_active = user.is_active
        self.info = user.info
        self.id = user.id
        self.email = user.email
        self.deleted_at = user.deleted_at
        self.created_at = user.created_at
        self.country_code = user.country_code
        self.bank_name = user.bank_name
        self.bank_image = user.bank_image
        self.account_number = user.account_number
        self.coin = user.coin
        self.is_notify = user.is_notify
        self.RememberMe = user.RememberMe
        self.set_image = user.set_image

        
    }
    
    
    func save() -> Void    {
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.setValue(encodedObject, forKey: "ELUser")
        UserDefaults.standard.synchronize()
    }
    
    func clear() -> Void
    {
        self.updated_at = ""
        self.type = ""
        self.token = ""
        self.reset_token = ""
        self.profile_image = ""
        self.nick_name = ""
        self.name = ""
        self.mobile = ""
        self.is_active = ""
        self.info = ""
        self.id = ""
        self.email = ""
        self.deleted_at = ""
        self.created_at = ""
        self.country_code = "+82"
        self.bank_name = ""
        self.bank_image = ""
        self.account_number = ""
        self.coin = "0"
        self.is_notify = ""
        self.RememberMe = ""
        self.set_image = ""

        EstalimUser.shared.save()
    }
    func setLoginData(dict:NSDictionary,isRememberme:Bool) -> Void {
        EstalimUser.shared.RememberMe = isRememberme.description
        
        if let value = dict.value(forKey: "set_image") as? String{
            EstalimUser.shared.set_image = value
        }
        if let value = dict.value(forKey: "language") as? String{
            EstalimUser.shared.language = value}
        if let value = dict.value(forKey: "updated_at") as? String{
            EstalimUser.shared.updated_at = value
        }
        if let value = dict.value(forKey: "type") as? String{
            EstalimUser.shared.type = value
            
        }
        if let value = dict.value(forKey: "token") as? String{
            EstalimUser.shared.token = value
            
        }
        if let value = dict.value(forKey: "coin") as? String{
            EstalimUser.shared.coin = value
            
        }
        if let value = dict.value(forKey: "is_notify") as? String{
            EstalimUser.shared.is_notify = value
            
        }
        if let value = dict.value(forKey: "reset_token") as? String{EstalimUser.shared.reset_token = value}
        if let value = dict.value(forKey: "profile_image") as? String{EstalimUser.shared.profile_image = value}
        if let value = dict.value(forKey: "nick_name") as? String{EstalimUser.shared.nick_name = value}
        if let value = dict.value(forKey: "name") as? String{EstalimUser.shared.name = value}
        if let value = dict.value(forKey: "mobile") as? String{EstalimUser.shared.mobile = value}
        if let value = dict.value(forKey: "is_active") as? String{EstalimUser.shared.is_active = value}
        if let value = dict.value(forKey: "info") as? String{EstalimUser.shared.info = value}
        if let value = dict.value(forKey: "id") as? Int {EstalimUser.shared.id = "\(value)"}
        if let value = dict.value(forKey: "email") as? String{EstalimUser.shared.email = value}
        if let value = dict.value(forKey: "deleted_at") as? String{EstalimUser.shared.deleted_at = value}
        if let value = dict.value(forKey: "created_at") as? String{EstalimUser.shared.created_at = value}
        if let value = dict.value(forKey: "country_code") as? String{EstalimUser.shared.country_code = value}
        if let value = dict.value(forKey: "bank_name") as? String{EstalimUser.shared.bank_name = value}
        if let value = dict.value(forKey: "bank_image") as? String{EstalimUser.shared.bank_image = value}
        if let value = dict.value(forKey: "account_number") as? String{EstalimUser.shared.account_number = value}
        EstalimUser.shared.save()
    }
    func setData(dict:NSDictionary) -> Void {
        if let value = dict.value(forKey: "language") as? String{
            EstalimUser.shared.language = value}
        if let value = dict.value(forKey: "updated_at") as? String{
            EstalimUser.shared.updated_at = value
        }
        if let value = dict.value(forKey: "type") as? String{
            EstalimUser.shared.type = value
            
        }
        if let value = dict.value(forKey: "token") as? String{
            EstalimUser.shared.token = value
            
        }
        if let value = dict.value(forKey: "coin") as? String{
            EstalimUser.shared.coin = value
            
        }
        if let value = dict.value(forKey: "is_notify") as? String{
            EstalimUser.shared.is_notify = value
            
        }
        if let value = dict.value(forKey: "reset_token") as? String{EstalimUser.shared.reset_token = value}
        if let value = dict.value(forKey: "profile_image") as? String{EstalimUser.shared.profile_image = value}
        if let value = dict.value(forKey: "nick_name") as? String{EstalimUser.shared.nick_name = value}
        if let value = dict.value(forKey: "name") as? String{EstalimUser.shared.name = value}
        if let value = dict.value(forKey: "mobile") as? String{EstalimUser.shared.mobile = value}
        if let value = dict.value(forKey: "is_active") as? String{EstalimUser.shared.is_active = value}
        if let value = dict.value(forKey: "info") as? String{EstalimUser.shared.info = value}
        if let value = dict.value(forKey: "id") as? Int {EstalimUser.shared.id = "\(value)"}
        if let value = dict.value(forKey: "email") as? String{EstalimUser.shared.email = value}
        if let value = dict.value(forKey: "deleted_at") as? String{EstalimUser.shared.deleted_at = value}
        if let value = dict.value(forKey: "created_at") as? String{EstalimUser.shared.created_at = value}
        if let value = dict.value(forKey: "country_code") as? String{EstalimUser.shared.country_code = value}
        if let value = dict.value(forKey: "bank_name") as? String{EstalimUser.shared.bank_name = value}
        if let value = dict.value(forKey: "bank_image") as? String{EstalimUser.shared.bank_image = value}
        if let value = dict.value(forKey: "account_number") as? String{EstalimUser.shared.account_number = value}
        EstalimUser.shared.save()
    }
    func setPrefranceData(dict:[NSDictionary]) -> Void {
        EstalimUser.shared.preference = dict
        EstalimUser.shared.save()
        
    }
}
