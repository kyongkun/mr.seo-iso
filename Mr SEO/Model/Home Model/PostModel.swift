/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class PostModel {
    public var post_id : Int?
    public var user_id : Int?
    public var title : String?
    public var color : String?
    public var email : String?
    public var register_point : Int?
    public var helper_count : Int?
    public var key : Int?
    public var HasAdvertise : Bool?
    public var advertisements : AdvertisementsModel?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let data_list = Data.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Data Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [PostModel]
    {
        var models:[PostModel] = []
        for item in array
        {
            models.append(PostModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let data = Data(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Data Instance.
*/
    required public init?(dictionary: NSDictionary) {

        post_id = dictionary["post_id"] as? Int
        user_id = dictionary["user_id"] as? Int
        title = dictionary["title"] as? String
        color = dictionary["color"] as? String
        email = dictionary["email"] as? String
        register_point = dictionary["register_point"] as? Int
        helper_count = dictionary["helper_count"] as? Int
        key = dictionary["key"] as? Int
        if (dictionary["advertisements"] != nil) { advertisements = AdvertisementsModel(dictionary: dictionary["advertisements"] as? NSDictionary ?? [:])
            if(advertisements?.image == nil){
                HasAdvertise = false
            }
            else{
                HasAdvertise = true
            }
            
        }
        else{
            HasAdvertise = false
        }
        
        
    }

        
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()
        dictionary.setValue(self.HasAdvertise, forKey: "HasAdvertise")
        dictionary.setValue(self.post_id, forKey: "post_id")
        dictionary.setValue(self.user_id, forKey: "user_id")
        dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.color, forKey: "color")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.register_point, forKey: "register_point")
        dictionary.setValue(self.helper_count, forKey: "helper_count")
        dictionary.setValue(self.key, forKey: "key")
        dictionary.setValue(self.advertisements?.dictionaryRepresentation(), forKey: "advertisements")

        return dictionary
    }

}
