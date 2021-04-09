/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class UserModel {
    public var id : Int?
    public var name : String?
    public var nick_name : String?
    public var country_code : String?
    public var mobile : String?
    public var profile_image : String?
    public var email : String?
    public var type : String?
    public var is_active : String?
    public var bank_name : String?
    public var bank_image : String?
    public var account_number : String?
    public var info : String?
    public var reset_token : String?
    public var created_at : String?
    public var updated_at : String?
    public var deleted_at : String?
    public var is_notify : String?
    public var coin : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let user_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of User Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [UserModel]
    {
        var models:[UserModel] = []
        for item in array
        {
            models.append(UserModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let user = User(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: User Instance.
*/
    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        nick_name = dictionary["nick_name"] as? String
        country_code = dictionary["country_code"] as? String
        mobile = dictionary["mobile"] as? String
        profile_image = dictionary["profile_image"] as? String
        email = dictionary["email"] as? String
        type = dictionary["type"] as? String
        is_active = dictionary["is_active"] as? String
        bank_name = dictionary["bank_name"] as? String
        bank_image = dictionary["bank_image"] as? String
        account_number = dictionary["account_number"] as? String
        info = dictionary["info"] as? String
        reset_token = dictionary["reset_token"] as? String
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
        deleted_at = dictionary["deleted_at"] as? String
        is_notify = dictionary["is_notify"] as? String
        coin = dictionary["coin"] as? String
    }

        
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.nick_name, forKey: "nick_name")
        dictionary.setValue(self.country_code, forKey: "country_code")
        dictionary.setValue(self.mobile, forKey: "mobile")
        dictionary.setValue(self.profile_image, forKey: "profile_image")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.type, forKey: "type")
        dictionary.setValue(self.is_active, forKey: "is_active")
        dictionary.setValue(self.bank_name, forKey: "bank_name")
        dictionary.setValue(self.bank_image, forKey: "bank_image")
        dictionary.setValue(self.account_number, forKey: "account_number")
        dictionary.setValue(self.info, forKey: "info")
        dictionary.setValue(self.reset_token, forKey: "reset_token")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")
        dictionary.setValue(self.deleted_at, forKey: "deleted_at")
        dictionary.setValue(self.is_notify, forKey: "is_notify")
        dictionary.setValue(self.coin, forKey: "coin")

        return dictionary
    }

}
