/*
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class ChatDetailsModel {
    public var id : Int?
    public var threads_id : Int?
    public var sender_id : Int?
    public var receiver_id : Int?
    public var message : String?
    public var file : String?
    public var type : String?
    public var status : String?
    public var sender_status : String?
    public var receiver_status : String?
    public var created_at : String?
    public var updated_at : String?
    public var sender_img : String?
    public var sender_name : String?
    public var receiver_img : String?
    public var receiver_name : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let data_list = Data.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Data Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [ChatDetailsModel]
    {
        var models:[ChatDetailsModel] = []
        for item in array
        {
            models.append(ChatDetailsModel(dictionary: item as! NSDictionary)!)
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

        id = dictionary["id"] as? Int
        threads_id = dictionary["threads_id"] as? Int
        sender_id = dictionary["sender_id"] as? Int
        receiver_id = dictionary["receiver_id"] as? Int
        message = dictionary["message"] as? String
        file = dictionary["file"] as? String
        type = dictionary["type"] as? String
        status = dictionary["status"] as? String
        sender_status = dictionary["sender_status"] as? String
        receiver_status = dictionary["receiver_status"] as? String
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
        sender_img = dictionary["sender_img"] as? String
        sender_name = dictionary["sender_name"] as? String
        receiver_img = dictionary["receiver_img"] as? String
        receiver_name = dictionary["receiver_name"] as? String
    }

        
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.threads_id, forKey: "threads_id")
        dictionary.setValue(self.sender_id, forKey: "sender_id")
        dictionary.setValue(self.receiver_id, forKey: "receiver_id")
        dictionary.setValue(self.message, forKey: "message")
        dictionary.setValue(self.file, forKey: "file")
        dictionary.setValue(self.type, forKey: "type")
        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.sender_status, forKey: "sender_status")
        dictionary.setValue(self.receiver_status, forKey: "receiver_status")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")
        dictionary.setValue(self.sender_img, forKey: "sender_img")
        dictionary.setValue(self.sender_name, forKey: "sender_name")
        dictionary.setValue(self.receiver_img, forKey: "receiver_img")
        dictionary.setValue(self.receiver_name, forKey: "receiver_name")

        return dictionary
    }

}
